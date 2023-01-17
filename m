Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2466DBB1
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjAQLAd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 06:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjAQLAb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 06:00:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBC5253
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jan 2023 03:00:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2739945wms.4
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jan 2023 03:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjTar9pIMg4YcdUiGOQTXlFrNDMXufku6yVkHtLD7Ok=;
        b=Vkcb3tYUHj2/hrgvjzHtvofjpg1G5icS6gNHwP+2wuVGY37iQaA3Vc9FWWc9PXXr2+
         TJcoddy17th4qExslT+wdYvBJutW+cs2msJ6gIZ57qxWro5AgkiXsVpgTicsGeaog5Oq
         4vwO+2fM94+bOswpSiyWyckGQ3+44MxRRRAd6cI04IT+mdBVastXLplIoZd5xQ1gkV+z
         rng17+StW12XvFu9Cgx4Pyvzjd22JONF41jWwstI5OADTFRX+M4kBIhPiMMpEklpwPMP
         8fVGmYMc+E9R3H8mp08z+Gu84jh2RTeUlsCem9GSqxhoZ1FWmXykSDM/UZAe+8g/zbEc
         bhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjTar9pIMg4YcdUiGOQTXlFrNDMXufku6yVkHtLD7Ok=;
        b=ichjzqIEx/JeStV2MUJMqBCt278WdQFrNXyxu+Bxip/QIkV/YY1fKZigKlrhbt8G4d
         sXrTkH8I7eiZFT7n0spT/BAOMctlN64L1Jc7sHKujtkz3IHsWSaSnBsnV6BOVSb12VFt
         X5l+UjKP5vuMpCPAYXedBmkpE0hmNhZuNJmJRKv1vIupQu0tpmOr/dRh58/YULKFH9K8
         VTrqePeYXMTNmJxnUPcHUXYjg32XtFAPemlhIiwD5FukF/+cpGtlsPG6phvdzOSwWdNp
         tfnmfUWO5m3Q5sOMjMA2mPuietvRRi79HaTUqIzOtwLUk+431ZNZoI/bgKD+ZKKsukbz
         4jPQ==
X-Gm-Message-State: AFqh2krERH8/Zt9lYJsuhPBtOZvuap891Y/SYJEjOSBDM9TFDAlk/Uph
        IJ5L3aPA6+pY51mIfGrUR0mcnZVFTU4=
X-Google-Smtp-Source: AMrXdXse+HO9FvYJQASLuTVsaEMM3Jzhkd35LKLEB/xl5McrXduoVaI5LH3ZSryK/M7jBCuvjqj9cw==
X-Received: by 2002:a05:600c:1c02:b0:3d2:3b8d:21e5 with SMTP id j2-20020a05600c1c0200b003d23b8d21e5mr2612105wms.14.1673953229380;
        Tue, 17 Jan 2023 03:00:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c1d0e00b003da105437besm20349619wms.29.2023.01.17.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:00:28 -0800 (PST)
Date:   Tue, 17 Jan 2023 14:00:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     Tianyu.Lan@microsoft.com, linux-hyperv@vger.kernel.org
Subject: Re: [bug report] x86/hyperv: Add Write/Read MSR registers via ghcb
 page
Message-ID: <Y8Z/ycimio0p1cQP@kadam>
References: <Y8UM59rdoCD0D6V2@kili>
 <ac8ee542-1f60-fa66-99f5-d716cd2dff33@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8ee542-1f60-fa66-99f5-d716cd2dff33@linux.microsoft.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 17, 2023 at 04:26:13PM +0530, Jinank Jain wrote:
> Does making 0 as the default value makes sense?
> 

That would silence the warning, and most distros are going to enable
the config to zero it out anyway so it has no impact on runtime.

regards,
dan carpenter

