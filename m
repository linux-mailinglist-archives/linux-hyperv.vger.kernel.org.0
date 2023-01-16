Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABC766B920
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jan 2023 09:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjAPIiN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 03:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjAPIiM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 03:38:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45205CC02
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Jan 2023 00:38:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z5so25637325wrt.6
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Jan 2023 00:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GiW228DfGjUedbTvWRCWDmhJEXIQs2GvuGTtpxavGw=;
        b=Y6MrOU/8Kx6FHI8XAFvxm7brWVLIU0tSV2vVVEu/kbK+CowXRCMTa5ci/oj9OwkJNa
         cjBWl6J4vHyQtgXyZoNHzUI3SCuv9Cg47cZb5C1BLjvHj4B0lKrtNsQOycmT8d/eGMZl
         tFMDxKyAy/n0k9pbm8i1pC26jA3Im2mRuOVEJwV0sgvGh3bVFeLxVdqXAEtrGioXwrcL
         lcl6KVlDJBt8cmISrSmk9L0dl3YrHOnOKuj5knc0In06E3d9w1ZM7PmPaFRC0zZjL1K6
         XZ86K2SS5lOVxuX8cthE2WRd491jnVwcnQP0m74irdPsoH8oWs+kKd+KChg6RRFDY/fL
         Yxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GiW228DfGjUedbTvWRCWDmhJEXIQs2GvuGTtpxavGw=;
        b=b/GywtUoBChORlYDjEqHKpvAjw13O757gH3aK7YpMLU2KMdKw76JUM/vCmKSkaIHdW
         4GG0RfNsCQnBhyWSKNcRZCwvDPngEMHtBdIsGnORgsI96ZZ+U7jFfnDnSSCAG5JNzttZ
         nZewsZThtSDIx9pzcdtnzoo3aMcwQ9IaEgfriD4RClMpA+vuNKgYIrDlTaR56p/TCsRX
         i8sYlQ3G3hKfZSAyVC+IDK3rfWHtrbN4IQAacnDxwILuSaqYi0RvWuj/KQEfR8W6jRuu
         Ed2okf26dprWrrtU7mkWcmVss1HakPqnGjKB8UWBEV12Ovg47c8IJm/R8gjtJTKMt/oc
         XTQw==
X-Gm-Message-State: AFqh2kqEEhKH54Hu9QOnbALr6p+nBNmNu1OsSHpbX48Y4/tkZLQFEPqK
        qPAgr/B5UOAZ99Y6zXVOlJI=
X-Google-Smtp-Source: AMrXdXt6IVlCbCdaGeb/8B4j28bKH1WYkRIvbQA/g8gVMZbDnWzb2nm0gSsNN/LrWP1TCgzcacV08w==
X-Received: by 2002:a05:6000:85:b0:2bc:7fdd:9245 with SMTP id m5-20020a056000008500b002bc7fdd9245mr17792439wrx.5.1673858289697;
        Mon, 16 Jan 2023 00:38:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm25838145wrj.2.2023.01.16.00.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 00:38:09 -0800 (PST)
Date:   Mon, 16 Jan 2023 11:37:59 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Tianyu.Lan@microsoft.com
Cc:     linux-hyperv@vger.kernel.org,
        Jinank Jain <jinankjain@linux.microsoft.com>
Subject: [bug report] x86/hyperv: Add Write/Read MSR registers via ghcb page
Message-ID: <Y8UM59rdoCD0D6V2@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Tianyu Lan,

The patch faff44069ff5: "x86/hyperv: Add Write/Read MSR registers via
ghcb page" from Oct 25, 2021, leads to the following Smatch static
checker warning:

	arch/x86/kernel/cpu/mshyperv.c:73 hv_get_non_nested_register()
	error: uninitialized symbol 'value'.

arch/x86/kernel/cpu/mshyperv.c
    63 
    64 #if IS_ENABLED(CONFIG_HYPERV)
    65 u64 hv_get_non_nested_register(unsigned int reg)
    66 {
    67         u64 value;
    68 
    69         if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
    70                 hv_ghcb_msr_read(reg, &value);
                                             ^^^^^^
There are three places in hv_ghcb_msr_read() which don't initialize
value.

    71         else
    72                 rdmsrl(reg, value);
--> 73         return value;
    74 }

regards,
dan carpenter
