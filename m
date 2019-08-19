Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D50925B5
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Aug 2019 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfHSOBn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 10:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfHSOBn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 10:01:43 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7CA77BDB7
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Aug 2019 14:01:42 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 19so568595wmk.0
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Aug 2019 07:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=G0gf91m0mqz0EZcVgsC94AuBuD97ccQue1GqDrTQ7QU=;
        b=M5cPDPivYopzt6fbWtIk5dGvEreL1tkOOYAfPsXDXqmdFR38vViD6GRs38AxRWOFN8
         lcpvQSav/neQX6z7ocnjtC25iavowt6nwU2/ybJg+Xrzpcd8jrqzAwwps9dkrZFBT3yS
         tc/aix4Sxu9fR1FtyolCmZ5nFt0FLbq1W6A/+k7OXZiCO7owUUBjRvhi0ffouwKs+Hgn
         fh2OdO9DsnNxjhXEickwv3ibKeT8ZA+I6nZVCURwh+vf1cawUgZsQaSiQuGcd0aJdiSs
         AmfH7GJasiV9tZOIORDV8tHOOjF+FDjVXJx7yHaDdrfiK6BWGJuvkLBXiUgqXt3bh6CI
         mU7w==
X-Gm-Message-State: APjAAAWIquohWClgCPb4rm2xStqTYWBQjBDifiyfDDkcBbW/3GI8Tthq
        KNhcGLvbwCS1NkBo5LARUwG52MFKhCToUo/rpkYGdwgWVbIetduCyzSENq/q0QSaFhHa8ETm/SD
        BknI1YQqphCW8IIw9eaZ2cw8O
X-Received: by 2002:a05:600c:207:: with SMTP id 7mr20158955wmi.146.1566223301460;
        Mon, 19 Aug 2019 07:01:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJ6wFYAq+FfS44FSXSvD26ATVBQIFeE9PJ6RyIsd9NSOKnmBtSdhaP7zGw9+MKbNlqzJ+78Q==
X-Received: by 2002:a05:600c:207:: with SMTP id 7mr20158922wmi.146.1566223301148;
        Mon, 19 Aug 2019 07:01:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j15sm13211558wrn.70.2019.08.19.07.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:01:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2] Tools: hv: move to tools buildsystem
In-Reply-To: <20190819124100.81289-1-andriy.shevchenko@linux.intel.com>
References: <20190819124100.81289-1-andriy.shevchenko@linux.intel.com>
Date:   Mon, 19 Aug 2019 16:01:39 +0200
Message-ID: <87pnl16ypo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> There is a nice buildsystem dedicated for userspace tools in Linux kernel tree.
> Switch Hyper-V daemons to be built by it.
>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

While testing this I noticed that we get a warning (gcc-8.3):

hv_kvp_daemon.c: In function ‘kvp_get_ip_info.constprop’:
hv_kvp_daemon.c:812:30: warning: ‘ip_buffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct hv_kvp_ipaddr_value *ip_buffer;

while this is clearly a false positive, I'd still want it to
disappear. I'll send a patch.

> ---
> - fix commit message (Vitaly)

Thanks!

>
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

-- 
Vitaly
