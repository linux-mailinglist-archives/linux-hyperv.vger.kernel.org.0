Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF45187F2
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 May 2022 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiECPLv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 May 2022 11:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbiECPLm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 May 2022 11:11:42 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D53A5EB;
        Tue,  3 May 2022 08:08:10 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id i5so23759914wrc.13;
        Tue, 03 May 2022 08:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OFDYOtaeBYWdI/VdYgSv21m5XBBjgU/ODz2WZHmBn3Q=;
        b=v/IhySNd6YcyBWVPAJtPlG6svioReVtcopsRuRY4B++F0yOS8zFCjbJriymv90zE1K
         RPBvBVl3eg7fjCYKRRJSFFRy9CWyyUPrt2hRs+oORJg8DZIipB2RZFqGubvbVIhY9xNj
         3ANpybjIjSIsrFeo9CiloyOauZxWMH1pstne0RVvlVG4VvFilpvVFNZmIy+tK0dq/o0C
         lhW+3Lzn/c/dRmsMJ67bJQSP4JVzC8TpghjKD6hxDmoQW3FLz+PqWF9cTzQRis32dXZx
         dWnKgzXg4QBg5Au/It48ni12rLM/TvGongRXls6DwZQTcnaxVmmx3MG1FhBuOxxJ8j4U
         vPUg==
X-Gm-Message-State: AOAM533T1GLgy/nFj9IUg3XjMHF6tbVCzTONkdGPshts75yC9Ce7cQdY
        eyk2E9Lld0jQuGFb+r496Ss=
X-Google-Smtp-Source: ABdhPJxUHgC+z861mLwWBsRMd0+WqwbQOXHy1VunvJ23KhKxVuDMs2AqWeh+/Td2z8ZSYIVytBegWQ==
X-Received: by 2002:a05:6000:1acd:b0:20c:726a:3840 with SMTP id i13-20020a0560001acd00b0020c726a3840mr3707076wry.507.1651590489041;
        Tue, 03 May 2022 08:08:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g17-20020adfbc91000000b0020c5253d8f3sm11729850wrh.63.2022.05.03.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:08:08 -0700 (PDT)
Date:   Tue, 3 May 2022 15:08:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v4] drm/hyperv: Add error message for fb size greater
 than allocated
Message-ID: <20220503150806.neeemkwlexmyqsnd@liuwe-devbox-debian-v2>
References: <1649737739-10113-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB127064CAEA28FBBFB34672C3BFED9@BYAPR21MB1270.namprd21.prod.outlook.com>
 <20220503145016.GA25079@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503145016.GA25079@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 03, 2022 at 07:50:16AM -0700, Saurabh Singh Sengar wrote:
> On Tue, Apr 12, 2022 at 05:06:07AM +0000, Dexuan Cui wrote:
> > > From: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > Sent: Monday, April 11, 2022 9:29 PM
> > >  ...
> > > Add error message when the size of requested framebuffer is more than
> > > the allocated size by vmbus mmio region for framebuffer
> > 
> > The line lacks a period, but I guess the maintainer may help fix it for you :-)
> >  
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > 
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> 
> Can this be queued for next ? please let me know in case any clarification required.

Applied to hyperv-next. Thanks.
