import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4 Configuration
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Jardín Digital de Marko",
    pageTitleSuffix: " | Marko Bremer",
    enableSPA: true,
    enablePopovers: true,
    analytics: null,
    locale: "es-ES",
    baseUrl: "ideas.markobremer.com",
    ignorePatterns: [
      "private",
      "templates",
      ".obsidian",
      "**/.git/**",
      "CLAUDE.md",
      "**/CLAUDE.md",
    ],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Inter",
        body: "Inter",
        code: "IBM Plex Mono",
      },
      colors: {
        lightMode: {
          light: "#FFFFFF",
          lightgray: "#F6F6F6",
          gray: "#ECECEC",
          darkgray: "#646F82",
          dark: "#181818",
          secondary: "#181818",
          tertiary: "#C5E5DD",
          highlight: "rgba(197, 229, 221, 0.25)",
          textHighlight: "rgba(197, 229, 221, 0.5)",
        },
        darkMode: {
          light: "#181818",
          lightgray: "#252525",
          gray: "#404040",
          darkgray: "#b0b0b0",
          dark: "#F6F6F6",
          secondary: "#F6F6F6",
          tertiary: "#C5E5DD",
          highlight: "rgba(197, 229, 221, 0.15)",
          textHighlight: "rgba(197, 229, 221, 0.3)",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      // Comment out CustomOgImages to speed up build time
      // Plugin.CustomOgImages(),
    ],
  },
}

export default config
