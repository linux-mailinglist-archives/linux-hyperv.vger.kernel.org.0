Return-Path: <linux-hyperv+bounces-5711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C1FACBDD6
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 01:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F134E3A1631
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jun 2025 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C42AE6C;
	Mon,  2 Jun 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVr9M4G4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712EDF58
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Jun 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908541; cv=none; b=FYl35qhf+NYJHjFj7Djys2BY0WNPTWlMIaMTSTjlCVnKSvGYXEUe8GHIMZxDbZAXw7MI3XYXzwtLVrFQUP5ZkST47dpPfnWmFRr+FL+mFoCkhjykWRKP3bQR92jwlFI/2CLCozz34C2g0N5pJ96HVa3w3TwwOYez0v2tpww8HsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908541; c=relaxed/simple;
	bh=Ju916P4sYnWVZTh2DNePmcv9FVZBwdgHklNdqd8Oijg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S63qijZmDoqr6ELQf69NRNmVW7kXZ9PGa22Fg1mXiewJoO7zrcXrh7iwz9zFVkSv5+wEwmwq9aOLLR0Q8KT35QMSCX7zzaX5SqxbbGgfe1C/7EnM3LoPUGNkoYxwcy5nHkDWyIDZXztyvCQ/E8XDCh5PRsefxliYbGeryu2dD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVr9M4G4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26ee6be1ecso3340864a12.0
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Jun 2025 16:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748908539; x=1749513339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npV9To5pQZdbdXSNZhlEDjO/E7dDrAFqXMf7ITr4EOY=;
        b=OVr9M4G4GQGNkU/AjDFXg20vmgoH5RX54XRMcPYUTpIqsXqaLGu9SmVdrieo04ct2w
         GF5MKxqEY2cifvZFYVdiGhJh2S2H5mcTbzI75ht72QFt4pAIqSg1SpvkpKVI19MchclL
         84Z8CaS4qAc47uZkz9ynAf9afy9RJSklMIptvJMrmgIDDk49YJWq8XPBUfggAX3QMaCr
         IChhgY9Rn/t29II0M//oM2fyNt2cbUBLn2DJOVzaD1ahrgDT5iX/AYXHMfTEum8SumvV
         //3N0tmoeAgKA4/yOEVmlo9THmAsbicdhW+lN8aYhd9IZLnM1WROlCMd1izaggeCued7
         e8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748908539; x=1749513339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npV9To5pQZdbdXSNZhlEDjO/E7dDrAFqXMf7ITr4EOY=;
        b=UwU3sfnOXRU6bHRU232/3z9bkg/B+ox5LPRuzU6R/YOpUjW46K/ZdAnPNlD+pNWYGd
         QApfeE0qRNHuqHba6jP+piU+WOFXycs6osuqgCz9mWgZqGtAXhCNQFT0HwHMh6g6x0Xo
         RMP57OSbe9PoW7r46liT2PTN7SBQ/6SbAeJZlw1oRiTl3ZECZXUgC/nuiHn8bsrlcXkX
         NO3hi6NH7QfUoZZD5f12TsuHrv8d84f945/oS4go7VTKbPnmEURxZVwFxc5fT2DGw/s4
         GkfIYmizNSn6fpZ0DxRqin8+Z99n9OzDn9xgwFMvzH7DVlEobdV8hCaZM52HBd8NP+k2
         o1lQ==
X-Gm-Message-State: AOJu0Yy48Cobt3ETZKhrSTjzPgd5TK1UZCIab1dgwp7s4k0mdUyAUWWy
	BnqvQBH1z5QcKIZfHzHaO/UzhfF7pgOmtIN4AcnNKoEcSWHijgoB45b/IVy3iw==
X-Gm-Gg: ASbGncsOoykP0cg2vnL6YKxctCyn2s70/tpcmH0C6KATUqKDWrTfWUPAQA/zqbIU0+F
	qeH9xnNSy2kVR/zdJmv5xeEBLm+IdhKV5cR2Nd/xBL0I8KZJxTE30uA/snRj6bKubhclIYRQ7ZJ
	TkxklMXKXxk1Sr2Tjv/9oRq4p097JUUxh/wtjGly37GC49Lbln5BgtgCAUppiwz49iBbVmYjTcl
	CtewLmSM1Hv3xxDDuAsZXGGl3g8N9Q9JQqSqtVHrH0fLqUs2hF1L7V/Duc23JLv8sqtngVLHiA0
	4qa0AFRAOJz9G/feWD0pMf4Uq3xmHNZ4Cm3ziJkOT+3f7/qiypay0+3GZtE3QfWEuWw4a7cCVRa
	bcMSI/cDn35QvhsvgwX6/maraUwg=
X-Google-Smtp-Source: AGHT+IHbunmabIycG5JBSGo/Z4xYfr682AWax5OK5MizXw32rzSf/oZ3ZDK5Y5nVuxmUsb9hL4/RFA==
X-Received: by 2002:a17:90b:48d0:b0:312:25dd:1c86 with SMTP id 98e67ed59e1d1-31250422ca8mr24163458a91.18.1748908539152;
        Mon, 02 Jun 2025 16:55:39 -0700 (PDT)
Received: from fc42.mshome.net (p3626248-ipxg13201funabasi.chiba.ocn.ne.jp. [61.207.103.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3c0db6sm6766881a91.34.2025.06.02.16.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 16:55:38 -0700 (PDT)
From: yasuenag@gmail.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v2 0/1] Path string from the host should not be treated
Date: Tue,  3 Jun 2025 08:55:13 +0900
Message-ID: <20250602235514.1527-1-yasuenag@gmail.com>
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


