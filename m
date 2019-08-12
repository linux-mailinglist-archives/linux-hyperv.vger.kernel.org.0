Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E508A64F
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Aug 2019 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHLS2F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Aug 2019 14:28:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:31130 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfHLS2F (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Aug 2019 14:28:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="170142286"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga008.jf.intel.com with ESMTP; 12 Aug 2019 11:27:18 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hxF2K-0001mk-Vy; Mon, 12 Aug 2019 21:27:16 +0300
Date:   Mon, 12 Aug 2019 21:27:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v1] Tools: hv: move to tools buildsystem
Message-ID: <20190812182716.GS30120@smile.fi.intel.com>
References: <20190628170542.28481-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628170542.28481-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 28, 2019 at 08:05:42PM +0300, Andy Shevchenko wrote:
> There is a nice buildsystem dedicated for userspace tools in Linux kernel tree.
> Switch gpio target to be built by it.
> 

Any comments on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  tools/hv/Build    |  3 +++
>  tools/hv/Makefile | 51 +++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 44 insertions(+), 10 deletions(-)
>  create mode 100644 tools/hv/Build
> 
> diff --git a/tools/hv/Build b/tools/hv/Build
> new file mode 100644
> index 000000000000..6cf51fa4b306
> --- /dev/null
> +++ b/tools/hv/Build
> @@ -0,0 +1,3 @@
> +hv_kvp_daemon-y += hv_kvp_daemon.o
> +hv_vss_daemon-y += hv_vss_daemon.o
> +hv_fcopy_daemon-y += hv_fcopy_daemon.o
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 5db5e62cebda..b57143d9459c 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -1,28 +1,55 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for Hyper-V tools
> -
> -WARNINGS = -Wall -Wextra
> -CFLAGS = $(WARNINGS) -g $(shell getconf LFS_CFLAGS)
> -
> -CFLAGS += -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
> +include ../scripts/Makefile.include
>  
>  sbindir ?= /usr/sbin
>  libexecdir ?= /usr/libexec
>  sharedstatedir ?= /var/lib
>  
> -ALL_PROGRAMS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif
> +
> +# Do not use make's built-in rules
> +# (this improves performance and avoids hard-to-debug behaviour);
> +MAKEFLAGS += -r
> +
> +override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> +
> +ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> +ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>  
>  ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
>  
>  all: $(ALL_PROGRAMS)
>  
> -%: %.c
> -	$(CC) $(CFLAGS) -o $@ $^
> +export srctree OUTPUT CC LD CFLAGS
> +include $(srctree)/tools/build/Makefile.include
> +
> +HV_KVP_DAEMON_IN := $(OUTPUT)hv_kvp_daemon-in.o
> +$(HV_KVP_DAEMON_IN): FORCE
> +	$(Q)$(MAKE) $(build)=hv_kvp_daemon
> +$(OUTPUT)hv_kvp_daemon: $(HV_KVP_DAEMON_IN)
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> +
> +HV_VSS_DAEMON_IN := $(OUTPUT)hv_vss_daemon-in.o
> +$(HV_VSS_DAEMON_IN): FORCE
> +	$(Q)$(MAKE) $(build)=hv_vss_daemon
> +$(OUTPUT)hv_vss_daemon: $(HV_VSS_DAEMON_IN)
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> +
> +HV_FCOPY_DAEMON_IN := $(OUTPUT)hv_fcopy_daemon-in.o
> +$(HV_FCOPY_DAEMON_IN): FORCE
> +	$(Q)$(MAKE) $(build)=hv_fcopy_daemon
> +$(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
>  
>  clean:
> -	$(RM) hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> +	rm -f $(ALL_PROGRAMS)
> +	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>  
> -install: all
> +install: $(ALL_PROGRAMS)
>  	install -d -m 755 $(DESTDIR)$(sbindir); \
>  	install -d -m 755 $(DESTDIR)$(libexecdir)/hypervkvpd; \
>  	install -d -m 755 $(DESTDIR)$(sharedstatedir); \
> @@ -33,3 +60,7 @@ install: all
>  	for script in $(ALL_SCRIPTS); do \
>  		install $$script -m 755 $(DESTDIR)$(libexecdir)/hypervkvpd/$${script%.sh}; \
>  	done
> +
> +FORCE:
> +
> +.PHONY: all install clean FORCE prepare
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


