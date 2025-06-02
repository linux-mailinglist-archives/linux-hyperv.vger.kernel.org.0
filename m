Return-Path: <linux-hyperv+bounces-5712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50437ACBDD7
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7677A9DEF
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jun 2025 23:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4D2AE6C;
	Mon,  2 Jun 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw48Pi+5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E748DF58
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Jun 2025 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908581; cv=none; b=PS83BmeyuBvILV9GI9fcHXa4YlA5PRwFimWPri9bZImEcizmAiKcWHxoCLT2gsBbNX2JDuim7px6UQl7NFlhKRoKP1DF9H9fElCXXOsV9kIgVKI6LaE0JjSvlOOlwX1fRewHAOtwhrBTB5ED5kIDmJWcAjo0XKYxc6m2H7XODpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908581; c=relaxed/simple;
	bh=Ju916P4sYnWVZTh2DNePmcv9FVZBwdgHklNdqd8Oijg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBr53GvI+/ec4t1hFQryZYdiBg45L/FvhusZB5rehKZ+cZNOx12SwDBJ7oeK7z1TYo7hxlwgqemM8sZ14HcaJj0bxYW1xXlWNsX2dLkjgHvu/tF0AnTEYzqokWF7fix7IJsjXu7xVwosiF1QJa0MR2nw/NlPapzKSalNDQRDsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw48Pi+5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74019695377so3076640b3a.3
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Jun 2025 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748908579; x=1749513379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npV9To5pQZdbdXSNZhlEDjO/E7dDrAFqXMf7ITr4EOY=;
        b=Sw48Pi+5tnyeQ+T+G55jfVnmqtQoxeQRHkEaC/CpkD4K5wZhGgRUpCzxAHFfiQLCQ9
         KiI9tTtoFMlKtNN95O+Qw3DSQEKt88HmG/DjxQ5JGDO9GtLKewlJneUaLjxLWgtAajkB
         47HrGbBvSLVs5BGGDGu5sqTLGtIfTGWCJUGehcJeTKpycgo/l+nUAgUITZssM2m7T6MW
         kxd3JhIT8VVZibHlM3LWb0XlGXNXgz/FQuoYYo7vFOsezevwV4+0IqDkpTmGygjgNZDj
         v32cMsBUVDd2JqCb8agyBs9/aC+z3HT0jGSvTbWXAZMWJrNNzQ4JyAznPqiy20hOhooN
         D46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748908579; x=1749513379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npV9To5pQZdbdXSNZhlEDjO/E7dDrAFqXMf7ITr4EOY=;
        b=RuxkE9Uq056ho+yQo07i1MLaFEhpA7inAnAcSAV5cZEJ86luCs2XcN665mh6UUg+D0
         s0lTigIp8WksR2v2SW1/YgPx2KlKyA0JNWZoKxH0GhZ42iDxPZSai+Vg3tWxTnrub8RM
         +QKEJuiDRPaBiSX2YXG6ybM5swyQXIDxCfn3iQ939iCjFr3RwX1wjxkt7XUe/VYePhnD
         oLhnyQWQwHUkgUr076CcR5OzcWNl6ZGh+/POVfQT6+si/zKRcLxe7jGXAgxnMnNsMZUv
         39MLUdEjKZi5Rm4s01SXcCAZ+S2x7tIecNmwYfDmMlXCwasvLK8jQAPYrXSman9fXc/W
         9CdA==
X-Gm-Message-State: AOJu0Yw8XtwnBzo1qd8aA++zankhMOY/sHI0Ni2j+6J+INObT2YRyJqs
	sEnI7fDKDT/anSkdInl/kbt0DlbbVcUJyLoLuCh2ETbaYtsMcidt8u/d
X-Gm-Gg: ASbGncufxvaYL2vprD6uzjk5PQom+3M1J7rg38fCjsROWmIsL9Kr+OoTSFIm8qBBZWm
	80N4jq1f18iKTLb62/hvgpaTTijxP5ERQ/GbetwqkmLSOXuGfCA6htwBBiFXIHXM6+We7EbniQE
	6QZlGVSeS+J27DC58ZsVQcnv5N22E/JmpyDnyLcl+qQbKOHagENOxfP1vKy+KNDxlhWmGGCozgx
	8fWIH1wT/w9etuz1IpWTy8IMutPe3BOB7oFjPAdisb7BqQJ8zvAq/n/+wcpwouOjd5A3VTdRRar
	s0he5NXXPSPEWo0EVRG7PK5w+0/We33bahKwp5t/6/A0BGOYToNXLhfo+I+9cZitn/r69eWqdDy
	l/Vtolu4GCLQeX4WenL8RMz98lYU=
X-Google-Smtp-Source: AGHT+IFD60aiaHHK/VrRCAgTJpHFyvGzLznWU9ia0EVIy+5iyHblqqSfbtJ0OV/0EOJTueiHEVeQBg==
X-Received: by 2002:a05:6a00:9296:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-747d1ab0afcmr13450271b3a.20.1748908579175;
        Mon, 02 Jun 2025 16:56:19 -0700 (PDT)
Received: from fc42.mshome.net (p3626248-ipxg13201funabasi.chiba.ocn.ne.jp. [61.207.103.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd4398sm8467274b3a.134.2025.06.02.16.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 16:56:18 -0700 (PDT)
From: yasuenag@gmail.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v2 0/1] Path string from the host should not be treated
Date: Tue,  3 Jun 2025 08:56:11 +0900
Message-ID: <20250602235612.1542-1-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <82cbefe0-c9d0-457e-99dd-82842ee64cef@linux.microsoft.com>
References: <82cbefe0-c9d0-457e-99dd-82842ee64cef@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yasumasa Suenaga <yasuenag@gmail.com>

Hi,

Easwar, thanks a lot for your comment! I fixed where you pointed.
Let me know if something wrong in this patch - this is my first
contribution to Linux kernel...

Yasumasa Suenaga (1):
  Path string from the host should not be treated as wchar_t

 tools/hv/hv_fcopy_uio_daemon.c | 36 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

-- 
2.49.0


