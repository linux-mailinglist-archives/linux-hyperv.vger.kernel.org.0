Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119DD6BEBC2
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCQOxf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCQOxe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 10:53:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF140C0;
        Fri, 17 Mar 2023 07:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7ED76CE207D;
        Fri, 17 Mar 2023 14:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE28C433D2;
        Fri, 17 Mar 2023 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679064809;
        bh=vBinUK6v5Vl5tjes02qFnk41gtDZSyYAjCozcqBYGOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATGrVhcCGjXq20/8tlDohKbJjObLMoBeeDqjkavcP8PsQZUcu/3gkKRq695Ekwa4P
         EE/erBS/51411S7N71v+9NgNwr9T47AuPR1rp6eKR+/cIEjShthAyeQUUdhy+qKUR8
         bi6k9HbzikT1kbLrPW+/6GCO/JePG1J4zut/Ly+8dV2vaJ4mSfm1wAJ+weGcZKM+cY
         Db3KTE8SXEe/gfm4vPN77fMR7ow+dqa6sQtcbylCbIQQ0T7mkmERoz5eeJhW/z6n+J
         Uds95AvmIrOMhDsJc03P2JtLVCN7b5eKh//ESOTJkQ2oYHn1m9RW1d8Iu9bgbt5Ph9
         KJJPfY1JGNRIg==
Date:   Fri, 17 Mar 2023 07:53:27 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Message-ID: <20230317145327.sl7kzgxtlqgrte7j@treble>
References: <20230310152442.cbrjise6uex4ak4x@treble>
 <20230310154452.1169204-1-gpiccoli@igalia.com>
 <BYAPR21MB16888EBB51D1597F9B9C212FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <a1f40654-b3cf-5c77-561e-056f47cbff61@igalia.com>
 <BYAPR21MB1688673F3E49C9944E892894D7BD9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688673F3E49C9944E892894D7BD9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 17, 2023 at 01:40:25PM +0000, Michael Kelley (LINUX) wrote:
> From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Thursday, March 16, 2023 2:24 PM
> > 
> > On 10/03/2023 18:17, Michael Kelley (LINUX) wrote:
> > > [...]
> > > Just curious:  Should the actual function also be updated with
> > > __noreturn?   In similar situations, such as snp_abort(), the
> > > __noreturn attribute is both places.   I don't know what the
> > > guidance is on this question.
> > >
> > 
> > Hi Michael / Josh (and all), lemme know if you want me to submit a V3
> > doing that. The function is not called inside this own definition file
> > nor exported, so I'm not sure that'd be necessary, but glad to do so if
> > you prefer.
> > 
> 
> I don't have a preference.  I was just trying to make sure the details
> are all correct.  I'll defer to those with more knowledge of the
> __noreturn attribute than I have.

It's not required, but probably good practice to put __noreturn in both
places to make it more self-documenting.

-- 
Josh
