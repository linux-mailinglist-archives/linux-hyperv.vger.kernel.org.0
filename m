Return-Path: <linux-hyperv+bounces-4824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED2A814BE
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE388867E8
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 18:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877E23E340;
	Tue,  8 Apr 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgWWiGFq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932A256D;
	Tue,  8 Apr 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137420; cv=none; b=eRapqC1kymjwminaC0AdzveWeKPRyqKIhjl0wMhd6I8T/xOCqqJH50wKUYOyR19kf2kkOVfNeMnSjS6u0L6G1D2G7QhY7SUq55nxWyfG8qDdTmDzLXQm0hDvlLpFi2bMFtrJJSXytG9GCgOE0jYG6mHUk5FxF42SDZ0t5AghINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137420; c=relaxed/simple;
	bh=5k8hs6+JkPpkUdWzR/s42XOTU/MqiCalasShbvGEV1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RDmXOuBsGeGEjk8P5IZLKnmrXEtV96V5OGXIFmowczDd/fdfcflZPswhL7Ew1+ALtCPzXA9g/XWQldB7qXjO7gQusWlX+x7gXb0Rr8oFVXD/8F0PvA6Bm6U4ooP8p3l5cDGj4P2Fn2c33m2V+TxK2RVIcgDUDaodWGSociE5JzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgWWiGFq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c062b1f5so5021455b3a.0;
        Tue, 08 Apr 2025 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744137418; x=1744742218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEeigtXbuhczioF+6lFvsC87+fhHQtlYev57eI/FUBg=;
        b=fgWWiGFq+jArqL9ySGeHW0PDeuKXjB2aiytICVWiHiwLJnwqtfjDcD5sWDSKVdOeF8
         nyKIMsz4IZyZx2nwZBv7p0j31xL64cyS2tkB7LcdW3UX8IWkp2iMzWhYl4uCpSCZMHW/
         Vcl+KfjKd5OTFSPrEwDWK0utD1so8XLOzL+fp9yyyIK6YdLfQhHoE+UbCPT2FzueISif
         qHUNVC05H09u467QVxPkttw4PqhByshO3sVmkird7YrwFz6CsxpeZnhOV0o9AMUUsKa1
         aPbKTI8dXgWxjbjXCtLTeI7xRDdI2dUpIx95LLeyvNTbh6LVSaSVqK5hV/vZE62J/TQZ
         +pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137418; x=1744742218;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEeigtXbuhczioF+6lFvsC87+fhHQtlYev57eI/FUBg=;
        b=nhNW3MZJkQfRNcTDGRNPRcDUGnncGwVxb8RNYRsFaoOpnirmYUJuKlObbcXjZVq/LJ
         +CiBXgWcuCsgIPD94knmFsiwDbJh8BAocHJ91LulsAajGsJ95/3jfGmAVqazM1HqrbvT
         MdVB9JNljW1Dnuq5vBABXONL6HFOR6AgOu7MaGui3FGZK5F4LObWgGanVnxRLkJ4Z+qn
         AoqgXXUWdCCuu+po/A5XK58v22/WZeODY7jFsc8ucabHy054nY8yvot+oHlwNouHMgbl
         LCx4WwBT9I1Ewu+cL82Ul8bqZaSwxPzhrURcwZx5CTeDotxblA6wSLup3qo1mEbghNLm
         0Csg==
X-Forwarded-Encrypted: i=1; AJvYcCVTTkVQWIcXS3WYUkey6nJ3jLvd5NVh09qgv67eOLcfsinXAyTVvIrmsYTaeBXrv46QC3w1Ng1poPyV2ZP5@vger.kernel.org, AJvYcCW75bhLc4E0jU9OYGBOKpTEQqam0GV+DXnPdEtRd5k4NqqZzDYTNUMK4cdV7S9RkF+W7jYXd1evKeV7eA==@vger.kernel.org, AJvYcCXssFLQUA6QKhi69pntIRs9DhuafJC3zIdGJUYlgFdBCQhBC6RXQWApfiwNV1yTPkqH8xO3FmQb0EpBGb8g@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgv9fTS5M5FKHD2ei45wD5YCUx9La5ZQh1ap6sZ4DaYgXZlh5
	0EYIXPymdApUvpMHeXiArSNIucNqxqs55g0NCVBmYEUb1TIBXgGi
X-Gm-Gg: ASbGncv4JyVAxPfiPI6dghcgHcRw6iRGLSspvL6Hg4jC5ysUqXKgL/7k0cfBGYZjsKT
	Qg9BOjQiYZYBN/nd9LwaswhRoCtUlAdRgelJzhDqwGNpoiN2EtweF4MmNnnSqgnuj6eRxm9X+80
	EAX8AbL8OjPz70GWUhTxDxZ0gujzVIxwhanP4lyZWPiXs5sLCMu7c9Hf50NfCWXPkM5eO4ip7uz
	pD+1pKWOKBnahdTqIyQSQZbIpQrMa6YSTiNpl4ClRDM4DRV5esUeg5O66TjQQCYp9Hc55Vo8ru4
	CP9bXsK2u0foz10LcssMLfdukYO2kCBOk36ZM3othWse4DBZCqXl3OGS7zmUusepAEoHM7ak/i8
	0hUmn4KxpqKfhyjAoWgAj/m5TNmm6c7d/Cw==
X-Google-Smtp-Source: AGHT+IE3PGvOtJxss8WsloRc6dNnfNCVIij/xjc7LUujufO1C+pBYPdR2U2LJqkutAnOAYB1T4ZWLA==
X-Received: by 2002:a05:6a00:1152:b0:736:ab21:6f37 with SMTP id d2e1a72fcca58-73bae30912bmr152031b3a.0.1744137418368;
        Tue, 08 Apr 2025 11:36:58 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d32b2sm10960469b3a.5.2025.04.08.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:36:58 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: jayalk@intworks.biz,
	simona@ffwll.ch,
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
Subject: [PATCH 0/3] fbdev: Add deferred I/O support for contiguous kernel memory framebuffers
Date: Tue,  8 Apr 2025 11:36:43 -0700
Message-Id: <20250408183646.1410-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current deferred I/O code works only for framebuffer memory that is
allocated with vmalloc(). The code assumes that the underlying page
refcount can be used by the mm subsystem to manage each framebuffer
page's lifecycle, which is consistent with vmalloc'ed memory, but not
with contiguous kernel memory from alloc_pages() or similar. When used
with contiguous kernel memory, current deferred I/O code eventually
causes the memory free lists to be scrambled, and a kernel panic ensues.
The problem is seen with the hyperv_fb driver when mmap'ing the
framebuffer into user space, as that driver uses alloc_pages() for the
framebuffer in some configurations. This patch set fixes the problem
by supporting contiguous kernel memory framebuffers with deferred I/O.

Patch 1 exports a 'mm' subsystem function needed by Patch 2.

Patch 2 is the changes to the fbdev deferred I/O code. More details
are in the commit message of Patch 2.

Patch 3 updates the hyperv_fb driver to use the new functionality
from Patch 2.

Michael Kelley (3):
  mm: Export vmf_insert_mixed_mkwrite()
  fbdev/deferred-io: Support contiguous kernel memory framebuffers
  fbdev: hyperv_fb: Fix mmap of framebuffers allocated using
    alloc_pages()

 drivers/video/fbdev/core/fb_defio.c | 126 +++++++++++++++++++++++-----
 drivers/video/fbdev/hyperv_fb.c     |   1 +
 include/linux/fb.h                  |   1 +
 mm/memory.c                         |   1 +
 4 files changed, 109 insertions(+), 20 deletions(-)

-- 
2.25.1


