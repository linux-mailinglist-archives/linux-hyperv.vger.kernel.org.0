Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315BE6E5D71
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDRJdb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDRJda (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 05:33:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519AA193;
        Tue, 18 Apr 2023 02:33:28 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 893921EC0646;
        Tue, 18 Apr 2023 11:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681810406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tu7w8dR95qQSxIMKUDLtETy26y+R4a4nZQRB8fgzBoA=;
        b=edpTQjjE6vwyzVXPx7WohNnGlJcqkarkfbw2vOTcfdRMst6vKWZNKles0sgtvXEsBMfyXr
        L4hO0SGQRvAeh2iU3314Cyhxcee7zWmFtgtoiTFSDh63B3YHsd3Xcb6Ra4E2V6ruLD9m1x
        qCV2A0BSLaXL5xaCAmvj37pNHgb7tYc=
Date:   Tue, 18 Apr 2023 11:33:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, wei.liu@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix for applied series [PATCH v5 0/5] Hyper-V VTL
 support
Message-ID: <20230418093321.GAZD5j4SZ7QWmUyAXW@fat_crate.local>
References: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 17, 2023 at 10:12:39PM -0700, Saurabh Sengar wrote:
> [PATCH v5 0/5] Hyper-V VTL support is already applied, however
> there are couple of kernel test bot warning reported. This patch
> series on top of [PATCH v5 0/5] Hyper-V VTL support fixes these.
> I expect them to be squash commit on respective patches.

That was supposed to happen when applying those using -rc7 as a base.

Wei, what's up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
