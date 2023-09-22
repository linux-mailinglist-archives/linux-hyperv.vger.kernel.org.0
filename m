Return-Path: <linux-hyperv+bounces-201-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970517ABA84
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2CE56281E01
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979347352;
	Fri, 22 Sep 2023 20:29:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6103F4AB
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 20:29:18 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287BA19E;
	Fri, 22 Sep 2023 13:29:17 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6907e44665bso2496714b3a.1;
        Fri, 22 Sep 2023 13:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695414556; x=1696019356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWtsUoRr/XZOrcIX7VdV06rv+aK2Ytwp/S+nDpDIrig=;
        b=C4qF59zUbPqEmAfw1TCM2h47gj3Tz7CH2x2HNhL3obzgEIUf6UQppz2VaE8nBH51RH
         cqw2FQ64CySxfYHL/8zaYHwllQGT2Oc71grVYOYBo9ofq0nme0AcWAgXfyC9GFmTaI7k
         CZBtCBnp90biqzUD6JJXbLQac8c6FKO+PbjQ9dde5Se3jmZEnegsOEnyO6e7dTxm08Ra
         P6kqD47Zu6rzF3o6Wbwb+B1gBnJgBOqCslYOtSQ68UDAvi5k6klN1MmbeVfkVrQj7J3X
         FatIUpZ752QpPWh43usuoSFJl7wCsKo4ESo0r4cqETl/apSsAhDX876l7lt2Ak2jGnGz
         RvZg==
X-Gm-Message-State: AOJu0YzjHTcY/ptscq0NsCTDL8KT8Z/6QwYSX7GVlbztvNnzjo2nbdSa
	ORCgrwrJLIjnU6izsUe7tl8=
X-Google-Smtp-Source: AGHT+IHVit3Ti0rL+3+NOKgkIBKGfVAJ8X12Z7ZuDQR48MgS28XKFayJQRS1YGs+N12V6yNB97iYCg==
X-Received: by 2002:a05:6a00:2e86:b0:692:a727:1fde with SMTP id fd6-20020a056a002e8600b00692a7271fdemr481358pfb.14.1695414556542;
        Fri, 22 Sep 2023 13:29:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id y19-20020aa78053000000b0066684d8115bsm3705434pfm.178.2023.09.22.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 13:29:16 -0700 (PDT)
Date: Fri, 22 Sep 2023 20:28:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] hyperv: reduce size of ms_hyperv_info
Message-ID: <ZQ348XuCa6ofOHDu@liuwe-devbox-debian-v2>
References: <20230922192840.3886-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922192840.3886-1-olaf@aepfle.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 09:28:40PM +0200, Olaf Hering wrote:
> Use the hole prior shared_gpa_boundary to store the result of get_vtl.
> This reduces the size by 8 bytes.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Applied to hyperv-fixes. Thanks.

