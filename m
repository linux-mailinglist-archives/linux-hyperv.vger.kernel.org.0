Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D4626ECC
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Nov 2022 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiKMJuT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Nov 2022 04:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMJuS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Nov 2022 04:50:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D35D2C3;
        Sun, 13 Nov 2022 01:50:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668333015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YlpxTB8EHPiNnFnVviBDcUW+dBVdWWO+DIWc3aDwBl4=;
        b=MlzZA6tGnlYRKqXGQ00KD+ZANePxc1jW/TwxBgRF9gM245wy6U8f9wbtFn8bqDSQ/Znh86
        XOx+DB3oGMpe87jgLOJj+fNs1LBL6btacJCSkjO5IUlwKOlTu1G3RzWzZkDtEgAR/NqkhR
        LZuKXrRg7daqN2UaKqWTA7ZiXxf/Xh2lrLZ6kuThFlQWLTYyiYYeYNEnsTqlhepQJEzpUt
        pOoZNgUza/LBW0dMF1m//scQc58qVrj9m0VBHgSWL8zowJfQcWdxyPy7o+6DYVts5l/g4o
        QfWfZlxa8/SiZUJ7+n86M9uS+s7lk3eh3JD6khCFV7LJbCwxNwYcIyYoG0viWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668333015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YlpxTB8EHPiNnFnVviBDcUW+dBVdWWO+DIWc3aDwBl4=;
        b=6cIfDVijgQwXBJbTm3IRMdqGbUKWKSVjgO1NVAM3ouVGRJNHB6lzzuGZz8rfsdAGv1N6B1
        4NVnjpuj3INR8XAg==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: RE: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h
 not asm/mshyperv.h
In-Reply-To: <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Sun, 13 Nov 2022 10:50:14 +0100
Message-ID: <87wn7ztc89.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Nov 12 2022 at 21:55, Michael Kelley wrote:
> But I can see the problem with too much getting dragged into the VDSO
> builds.  If hv_get_raw_timer() is added to hyperv_timer.h, it should
> be under #ifdef CONFIG_X86.  Adding an #ifdef isn't ideal, and a more
> more proper solution might be to have a separate hyperv_timer.h include
> file under arch/x86/include/asm.  But the latter seems like overkill for just
> hv_get_raw_timer(), so I'm OK with the #ifdef.

We surely can have asm/hyperv_timer.h but TBH:

>>  static inline notrace u64
>>  hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
>>  {

hv_read_tsc_page_tsc() does not look architecture agnostic either. TSC
is pretty x86 specific :)

Thanks,

        tglx


