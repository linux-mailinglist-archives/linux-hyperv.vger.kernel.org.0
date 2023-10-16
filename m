Return-Path: <linux-hyperv+bounces-528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF057CA6F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9772F1C208E5
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B724214;
	Mon, 16 Oct 2023 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQPZvlpB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFE23740
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 11:50:29 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D238E
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 04:50:24 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b5f1a6267bso229166241.1
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697457023; x=1698061823; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KztZxB+FpIACvXHxkqcjgVyNEnICICN3V4gaPD4c2UQ=;
        b=RQPZvlpBhGb9OHENzQhoyKTSbIyWsRJC40RMm3h3BlSDZqqte7uVEI+WcgUUj5q6wA
         /WZd8o5rPCW3YT/pOmXqBfFKGmwDQ0wlW4GyktjsUvlpf8yO21gfWuDusKweiT9+Zy1y
         mVy4d175MV9zzgFgcQU/qvCL3j/Tqs2NOTSmut4Z4VJDlPl5f1ueM7Wt7OdWpAXtxrAO
         T33u+Z0SjCUPQJVB7Te00hs7AsPgP/ExDlL5hfNc4nW2GysauqdZvE74zY22+dr/hgn2
         9ke5nEpOUTkKL4w7/gLK10B6gXbXTHAIr7jkjV/zed0sKrSQTuuWKWlGnRr7cyvls5WH
         OFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457023; x=1698061823;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KztZxB+FpIACvXHxkqcjgVyNEnICICN3V4gaPD4c2UQ=;
        b=LasZ8X9I9XPnOIvDbgOQvp/+Fmxqpz2aFEGf+B2UWL2dDaDlMvP1jjL27NGW3+ImWk
         QEZ2gVGwQ34dP8beFcmlZrJLgef8zRX6x1zS7aaNHvSTXRekJIcpasbvz6I5gq7NHqGx
         wYwUXAOodNDfW4E7EMDZYZNx+RVBr9DB4WyGFc6XDKgTkJB6MAwXKP68uNwYcYf1AwVs
         GvpG9pJbY+pO9wT5GJ4/QaaDkRHmm6KedHKRdBRnAm/xHWtE9ZjZjDlgwlM0wnnEPnrX
         aMmDa4860VizJOVey0WxNOyADLDQt06k/XuuXHjkBbgXML9smcEkxhOF9kpJWAXPxbZ/
         WgYw==
X-Gm-Message-State: AOJu0Yxku5yVEbrsYp/1M3j9pa6A0kXCOGSy6RTD7AiSJTSmgSiEi9on
	aiPv8hiozAM5SaAMt8N7v6/vNzs6R5nECd/aalJw7eWTTnqtHg==
X-Google-Smtp-Source: AGHT+IHDwU0gpaq8sVKMeSKWQXEeDoNWmf37xL6L1zRCeoVowaNWl9NQnK1+T3Ia6Zh99f6kYbL9uEeLXZeeOeWq4NQ=
X-Received: by 2002:a1f:6e8c:0:b0:493:69f1:d12d with SMTP id
 j134-20020a1f6e8c000000b0049369f1d12dmr18083505vkc.1.1697457022545; Mon, 16
 Oct 2023 04:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Ionescu <aionescu@gmail.com>
Date: Mon, 16 Oct 2023 07:49:56 -0400
Message-ID: <CAJ-90N+sS6tuzMtRLOSan7WMZZ2g1H-iFc1F1ne631d2kgoi_g@mail.gmail.com>
Subject: Incorrect definition of hv_enable_vp_vtl in hyperv-tlfs.h
To: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

In arch/x86/include/asm/hyperv-tlfs.h, the following definition at
line 786 (in Linus' tree), I believe to be incorrect.

struct hv_enable_vp_vtl {
    u64                partition_id;
    u32                vp_index;
    union hv_input_vtl        target_vtl; <==== Here

For this hypercall, the TLFS and MSDN documentation states this field
is HV_VTL (u8) and not HV_INPUT_VTL (the bit-field used for targeting
hypercalls to specific target VTLs, which is not the case here).

I realize this is essentially a no-op in code at the moment, but for
correctness should be addressed? I'm happy to make a patch, but wanted
to make sure this isn't a mistake in TLFS/MSDN to begin with
(although, my copy of GDK headers would corroborate it's indeed HV_VTL
as well).

Best regards,
Alex Ionescu

