Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10125AD7EB
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Sep 2022 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIEQ4l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Sep 2022 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIEQ4k (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Sep 2022 12:56:40 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08340BDF;
        Mon,  5 Sep 2022 09:56:39 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id bp20so11620341wrb.9;
        Mon, 05 Sep 2022 09:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yM8u+cHN3wUIvlqKUHDwcJ2mNpXuajnzcZgsgkwy+mw=;
        b=VoQ64CsNXWlnE3rOqnxuaX93zjcO+UaC3l+HrJd2jI1t7NRi0wIgwybgTY3klQoG0B
         jh1tHKQewdvO69dSbCJczBCZb+ICTj7H/cvjIr3mO6nZHUlnChJ3mADsSvbIVDpkqoPb
         BzuSmsGoogtMYkMtNqmcCd+TlgQ4fSH9P6oxVTsCbKRofc9bOtKBYOfpojgu3EobXeik
         3gvZ3gwNIda/s7FJATOcvwYeFToe8cef5GCPyyhqgp4BYzazVp0r8dPWhxLzHEEOQDxr
         MmrIX2HIBBZkzKqtHC5oH01UwyCZFqjVqzdbjyo6uQBT8+QMaXFKhUwXTu7a/i1pj82z
         Z9PA==
X-Gm-Message-State: ACgBeo1mz5cW3xqaXGFkU9kY7ZrY85BO+IGdrINofoR0z9fthTnuwvka
        RJ8PTTg/P6CVyqreIrcDV+RpatCYzQ4=
X-Google-Smtp-Source: AA6agR5GqshmmWe3Z+P1TdPN1Zj54dC/TZ16/Xm5d37unaH9LN+/cPHwpfAaVWN2L9B+7knbkaRL2w==
X-Received: by 2002:a5d:480c:0:b0:225:55d9:202a with SMTP id l12-20020a5d480c000000b0022555d9202amr24800527wrq.483.1662396998264;
        Mon, 05 Sep 2022 09:56:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d14-20020a05600c34ce00b003a5f54e3bbbsm18086726wmq.38.2022.09.05.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 09:56:37 -0700 (PDT)
Date:   Mon, 5 Sep 2022 16:56:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Zhou jie <zhoujie@nfschina.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv/hv_kvp_daemon: remove unnecessary (void*) conversions
Message-ID: <20220905165633.ciwh7toc3ynd3n5i@liuwe-devbox-debian-v2>
References: <20220823034552.8596-1-zhoujie@nfschina.com>
 <SN6PR2101MB16931A789DA8673E9607F761D7729@SN6PR2101MB1693.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB16931A789DA8673E9607F761D7729@SN6PR2101MB1693.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 25, 2022 at 05:14:55PM +0000, Michael Kelley (LINUX) wrote:
> From: Zhou jie <zhoujie@nfschina.com> Sent: Monday, August 22, 2022 8:46 PM
> > 
> > remove unnecessary void* type casting.
> > 
> > Signed-off-by: Zhou jie <zhoujie@nfschina.com>
> > ---
> >  tools/hv/hv_kvp_daemon.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > index 1e6fd6ca513b..445abb53bf0d 100644
> > --- a/tools/hv/hv_kvp_daemon.c
> > +++ b/tools/hv/hv_kvp_daemon.c
> > @@ -772,11 +772,11 @@ static int kvp_process_ip_address(void *addrp,
> >  	const char *str;
> > 
> >  	if (family == AF_INET) {
> > -		addr = (struct sockaddr_in *)addrp;
> > +		addr = addrp;
> >  		str = inet_ntop(family, &addr->sin_addr, tmp, 50);
> >  		addr_length = INET_ADDRSTRLEN;
> >  	} else {
> > -		addr6 = (struct sockaddr_in6 *)addrp;
> > +		addr6 = addrp;
> >  		str = inet_ntop(family, &addr6->sin6_addr.s6_addr, tmp, 50);
> >  		addr_length = INET6_ADDRSTRLEN;
> >  	}
> > --
> > 2.18.2
> 
> The patch subject prefix for changes to this module is usually "tools: hv:"
> or "tools: hv: kvp:" and this patch should be consistent.  Check the commit
> log for tools/hv/hv_kvp_daemon.c for historical examples.
> 
> Modulo this tweak,
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

I fixed the prefix and pushed this to hyperv-fixes.

Thanks,
Wei.
