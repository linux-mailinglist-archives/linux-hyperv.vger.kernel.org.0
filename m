Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE48778374A
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHVBTi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Aug 2023 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjHVBTV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Aug 2023 21:19:21 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275D187;
        Mon, 21 Aug 2023 18:19:20 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bdf4752c3cso21893675ad.2;
        Mon, 21 Aug 2023 18:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692667159; x=1693271959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QapfFLaCt/wNGVFmPCUAbuh5qqv4rUy+Qh/cSOJE2Ek=;
        b=G69xHzQ69Xwr90IDuf2iTd3hj/q/lEMy/5FlJJx/5XWgFbxPlwQIrfoPhdNhkpGF18
         tslfoKTMxaNw3V1n5Kaid7SE13tNvvSGOCWIUru4C0Y4n/1kkLj6Lb1tsxlfQtf87as4
         ZwNN59MlsHzz6HNen/HHJVs+3+++pPxtIYX/oobeWMTuHOrfB7AL/99SiXBWTukW/2o2
         dvx0wk6mpuS92IN8uLe9qjOF52GOGFbz8VrrSR+QQ+M4TGIycNUZEmQNCahInvw3pegI
         KsPC1MayhoktZUtItgPkf30E8FleAz4A4F6Yn2jlgaKRobik6HoB95u/UOxEk0Vo+nlx
         jkCQ==
X-Gm-Message-State: AOJu0YxUCXKsgZoYedusUZsbB7YQKl1F3+PAFcsEuWYEZix0+8LlOL6g
        geMTq1iZSCP3tP67GdhIyFW5BiTnxEU=
X-Google-Smtp-Source: AGHT+IFkUFX3NUesGhiDiU53uRVdTgU54omInH5uKyANTQZXU0ReUEbyMc5aclILMzHOMbnxbR9Wew==
X-Received: by 2002:a17:903:25d4:b0:1bb:94ed:20a with SMTP id jc20-20020a17090325d400b001bb94ed020amr5563403plb.24.1692667159409;
        Mon, 21 Aug 2023 18:19:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001bf2dcfe352sm7633594plr.234.2023.08.21.18.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:19:18 -0700 (PDT)
Date:   Tue, 22 Aug 2023 01:18:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Don't dereference ACPI root object
 handle
Message-ID: <ZOQNA7IYbxzFMBhI@liuwe-devbox-debian-v2>
References: <fd8e64ceeecfd1d95ff49021080cf699e88dbbde.1691606267.git.maciej.szmigiero@oracle.com>
 <BYAPR21MB1688ACCF36131027A665EB06D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688ACCF36131027A665EB06D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 14, 2023 at 08:26:28PM +0000, Michael Kelley (LINUX) wrote:
> From: Maciej S. Szmigiero <mail@maciej.szmigiero.name> Sent: Wednesday, August 9, 2023 11:40 AM
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next, thanks!
