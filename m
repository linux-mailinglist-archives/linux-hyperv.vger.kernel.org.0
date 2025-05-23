Return-Path: <linux-hyperv+bounces-5647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD324AC2752
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6438A17B45A
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078B296FB9;
	Fri, 23 May 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpoufZkw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2151F0E37;
	Fri, 23 May 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016946; cv=none; b=eoVcsb+e71KmrUnik8ojfeDbG5Uf2EQH5UTHZHjpXVenJH2OW647CQva32XnjLgjv70+fji6Ns120NH04y9sNMhL5t7Seb1liKdT/EdpBROD0zmDkJ7UZwhTJr+bTLUhPk1b63tJl/tZbvir92K/2tdZRWQW6JJjvewxt2OXBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016946; c=relaxed/simple;
	bh=hz0JB9pzXQpSDr6pAMFPj1hF1BZKOfjGC0sQ6kmOQIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwqL3P46HSgsyJTvYVHryasHf7+Y311tanhjXUEBNP6Scq9njZ3GhZVaKWVkad/I9F+0HSC6lF1RoJW9OTbZOBPHauPv5q5DRdKOd6SFLsnV6oN+R1nQwT9H9JvEhTXWiJF2yeF3Z6gcloJrYwQzxFolj/EDudRajwtRVlFqaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpoufZkw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30ea8b7c5c2so115259a91.3;
        Fri, 23 May 2025 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748016944; x=1748621744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fcO9TXDJbv0PnpLhAYEgKHbgViS8WVoRG/IIez/PTTM=;
        b=LpoufZkwN19VCywWq9GHD9nNqlitZwRXJqamadrGJvNhd+6Ky8MYfEU4yLGhHhteyE
         1pc9UWwjRT0xznLWBANzfyB7tv3YHMnT9Zf2JsGFCDLj0D1hp1IXp/HHTNqYPFE2NI4w
         9S5PnrKjG6T+ViM+ev18HH9r79No43bdwsb5cwQPYd6a9H1RVPlCfxVrlG9B7DQHt9OS
         WomxwLGmW7yJoMiTH1x6BGAW3NsC5Y/0th/OB64Ct7/e+/mnJFIwaWpkziFsoJ0PULIC
         JGiAuZrHHZ8Wc7VcksmotMK6H6oisauAaGO8HHnIOZqneZM/119zCI2xy/mWPf5rWscE
         FBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016944; x=1748621744;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcO9TXDJbv0PnpLhAYEgKHbgViS8WVoRG/IIez/PTTM=;
        b=DxDJ4rf0PdxyrHaZVPD7UUX50Q0/c6XAHdeVyrDmL8AM5kPSgf4tMENxx8wdgxw1rE
         ReIFQKs9aPFf3qeLxkEc42m7nR6HD4DLD0yGdQ3MeLCEtGr2GpS3sIJC27QdDFlrt5fF
         keIOBJpe5wjlbHW8li/dsqtScbCmc1OSavnz9C9rXy/36KJm46DNmgZbZVbLvIyTXfs1
         TZGhs7ZruYkqPnv0+vq+P+dij/bkyRqTxYpgcUTi6BdBFi5KNktZdiaZl4OqMmJtYq3q
         rUY9pMsRkChY/CIFXnoXCGoBSTB12JG4PiZh/WSM8TZipFMrdLWduJAg62MhzMWSlqTX
         ALbw==
X-Forwarded-Encrypted: i=1; AJvYcCVr+MtDsMxTuLS5e6k7fWCSmkypSAArjhGq1Lbv/CnkUnb1dKXjlUqjMGfkYqvwDcLAnbmu19ETXzZmpryz@vger.kernel.org, AJvYcCWF262j+WK4Vw/d2AnH1CjtbvGX6pQqDaXGvjeATWudnLE0he/MSodNFiWGHYdk80V5SyXFir1RTRTVRQ==@vger.kernel.org, AJvYcCXnhOZX2VioUW+N/zQbvKUxWC0rPMh9TijOXVPPlqaG7e0mQVEv9fKnZmV9zCNHpZpjsB0NKAWognaca+0f@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkMCflZ41FbC2CtCm8MBLoB93LX2d0MTzFURuwLRv6MAZbD1s
	4FIMWVvtIRXqg4FyLwC5lLJB6+4FkRIjHIwU+FsrURN3HnVBDnnZPP8R
X-Gm-Gg: ASbGnctdTXjCN0vJNl4qzP4HvVUmElQTDENnZDeut4ladVqi0AJMf5h7GIxDDU2aerr
	XLQzPCoJC6ry3F4kXzkZbfLpxz/x5iIzOsL08rXY6HHCEsTdEDX0S1LQXQDQDrKoYeSwclrAKlk
	Cnz0iGPFBAtgMvZAHref5Rh7nobIFHgVdp372yWQOL35Ujf//1njojQ8vURfOgkjuXS9hbTnOok
	n1tLj8rxkFw+gp4sZinHgEVYzQmWfQvYYCLzTwmSsVInETGKgrMIrtfdYfXObe0h+e0YDzwIx5a
	ZcDBZvHqXwarvYZ88eG03bg/sKQ6opeQawgCQB867jg8hCj0uh6hNwmOZsL6iNVRaYrNsgdTr7h
	r+l+vzkfltRjV3jHJBFZVeTOYYY4bZEVmRO+wkc4q
X-Google-Smtp-Source: AGHT+IEBtJgfUd9PfG81gZCPku8xlj3yj9p8H5N/t60M0ZS5vpK6dBsg3ehnSMHrskKHTMOTXKcvtw==
X-Received: by 2002:a17:90b:48ce:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-30e7d53fedcmr53004820a91.17.1748016944385;
        Fri, 23 May 2025 09:15:44 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d46ffsm7526565a91.25.2025.05.23.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:15:44 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: simona@ffwll.ch,
	deller@gmx.de,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	akpm@linux-foundation.org
Cc: weh@microsoft.com,
	tzimmermann@suse.de,
	hch@lst.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/4] fbdev: Add flag indicating framebuffer is allocated from kernel memory
Date: Fri, 23 May 2025 09:15:20 -0700
Message-Id: <20250523161522.409504-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523161522.409504-1-mhklinux@outlook.com>
References: <20250523161522.409504-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Add a flag that fbdev drivers can set to indicate that the framebuffer
memory comes from alloc_pages() or similar as opposed to vmalloc()
memory. The flag is to be used by fbdev deferred I/O.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v3:
* This patch is new in v3. The definition of FBINFO_KMEMFB
  was previously combined into the next patch of the series.
  [Helge Deller]

 include/linux/fb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05cc251035da..a1121116eef0 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -396,6 +396,7 @@ struct fb_tile_ops {
 
 /* hints */
 #define FBINFO_VIRTFB		0x0004 /* FB is System RAM, not device. */
+#define FBINFO_KMEMFB		0x0008 /* FB is allocated in contig kernel mem */
 #define FBINFO_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
 #define FBINFO_READS_FAST	0x0080 /* soft-copy faster than rendering */
 
-- 
2.25.1


