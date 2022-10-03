Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3830A5F2CAC
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Oct 2022 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJCJBz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Oct 2022 05:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJCJB0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Oct 2022 05:01:26 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E922A71C;
        Mon,  3 Oct 2022 01:50:21 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id u10so15513300wrq.2;
        Mon, 03 Oct 2022 01:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Rkrx+2X1uI8y8EaK0vm6/8CJhWKYR67UczJ86spt5X4=;
        b=oeO9eRIU/XK6LicvsDZ3KxSt/vJTQwdDWt4qdZFZniPg5qyUs3oo759pavzf+d7g56
         gSylW9zsxD2mjdawZCAqPwoXM89oh7zqwMSbl80L0Di9Q/sUtzuiToC+PdZ1PVWS5nw5
         QygCB6ef/cye2ArvWJ8vJW9iZxZeDEC4069y5afAFMhsaxX+z36saBT4dEjN79CgXSsu
         GMUQjf1aMADwxqnHrwQrXIkmusMEchs+fGoiWwHTb0Tafr9iiYLz0GoTLXMI7bOIlymv
         Ql55g/7UNFN7FhQ+b+LZ+cdZ4r+TQr4lCjYEDYSsk0AXdhMjWD0S7vStoyN1ai4LXqOi
         0QRA==
X-Gm-Message-State: ACrzQf0hxYZU+T8ngWs7z+3e+gVjZEjFAQLtyvppwjjMoQzlXFCjzNp6
        Y0LjeonRKbf6UD+9JhJNhaE=
X-Google-Smtp-Source: AMsMyM6JjKb85YnUKmMyV8El+MM4WioFvW6pb6wGSK6gdjtKbvrAoBCnvdK9iK2FPM/NJ4hPwxTXDg==
X-Received: by 2002:adf:dd0b:0:b0:22e:4fa:51a5 with SMTP id a11-20020adfdd0b000000b0022e04fa51a5mr7305154wrm.692.1664787018821;
        Mon, 03 Oct 2022 01:50:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c2dd000b003b47e8a5d22sm16017773wmh.23.2022.10.03.01.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:50:18 -0700 (PDT)
Date:   Mon, 3 Oct 2022 08:50:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Message-ID: <YzqiSK/s/oExlSrb@liuwe-devbox-debian-v2>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
 <YzRVaJA0EyfcVisW@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRVaJA0EyfcVisW@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 28, 2022 at 02:08:40PM +0000, Wei Liu wrote:
> On Wed, Sep 28, 2022 at 05:56:40PM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > kmap() is being deprecated in favor of kmap_local_page()[1].
> > 
> > There are two main problems with kmap(): (1) It comes with an overhead as
> > mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when the
> > kmap's pool wraps and it might block when the mapping space is fully
> > utilized until a slot becomes available.
> > 
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, the
> > kernel virtual addresses are restored and are still valid.
> > 
> > In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
> > single thread and is short live. So, in this case, it's safe to simply use
> > kmap_local_page() to create mapping, and this avoids the wasted cost of
> > kmap() for global synchronization.
> > 
> 
> The kmap call in that function is not performance critical in any way,
> and at this point in the initialization process I don't expect there to
> be any contention, so the downside of kmap is not really a concern here.
> 
> That being said, kmap getting deprecated is a good enough reason to
> switch to kmap_local_page. And I appreciate this well-written,
> well-reasoned commit message.
> 
> I will apply it to hyperv-next later -- I doubt people will object to
> this change, but just in case.

Applied to hyperv-next. Thanks.
