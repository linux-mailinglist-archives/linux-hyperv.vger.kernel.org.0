Return-Path: <linux-hyperv+bounces-5727-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0207BACD058
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 01:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A40A1897E29
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CB19D8AC;
	Tue,  3 Jun 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En2MeIOp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF82155C82
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Jun 2025 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994194; cv=none; b=VwV8AS23WQU3Cxfs2AK4W0WsXM6d29vCmUDQU7i4D3wtkXm/Tl6MJU4hoSlH6pTh8jhhV4HPhWrYnfhjBPdfwna6vm/60Iya/Lov97clGtTZlrPiQMEEPEca2IBUaZV+yUOy0w06GM/OUcQm8FMimUXdKDpSodunr1cwsTARYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994194; c=relaxed/simple;
	bh=4HacnqRa57aRJD2EZFnK1L1lD0YUDxhL5uwE88tYh5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alpVWA+PEQHox/x53dVISbBzDZW4prCOx4QVRAV7XptTui4rJefwBCNGhmuDrZBpYmvy5hgEoT7wSaRFIQt3ZRkD/H5jbEi3XnbKlj6qWpWl4U1KFRkTHEpd2nNyY9aiP26v/ToSSpzKcV4RJzWObVvy9ZYzFdxTxdgWUwz7KwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En2MeIOp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7426c44e014so5184952b3a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Jun 2025 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748994192; x=1749598992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnXJPCtsSPG+gvRDGypG2rriUtLF/2QwMTOfJKB6zf8=;
        b=En2MeIOpPoF0sjJSHILkJbor72Q9a6oL7tIYblamKPeZfIQDYRfo89I1qm9tAd9lcQ
         pD4LJCTkSHIJlofl5sOOPNycEEQe2zUeYR/bVtJu1KYjVJGlXISEL89DFwtySYEQ1tyd
         1fFBsiRyuzEwWCAc+hnj2ItFrTJBVXDrvZg99ra3GkTAQO0kz7wSgOA1emxS+X5RTAkG
         TVc77H1hewX1Sa6Zg4CknkMPgtWbPDs8c3P8GStaMdlaUH+Z8iRGaKDmdvQbosAJ0IMQ
         VNY9oC9gzT8RCTUElle8WegES9CV8TqeUL8hwXLBgV64RqRykWA6OOCBYV3Jr6CPuTYO
         onqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748994192; x=1749598992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnXJPCtsSPG+gvRDGypG2rriUtLF/2QwMTOfJKB6zf8=;
        b=aPF9LjfNUY8IgFyq1Tiej+T8FbIClpWjqvDEH3UuoaCESQkaou4zGBYMbpScfKN4if
         qbBK3rjnRV9gBB8L/ZLaWkHB8RPIiU/1x3kwN9m1L7CTKFkUwvEIAaME1DOlyR3/FK50
         +oV1k1QBjf0Twa/xMh34dSc5IPZrOhvT9G5xAWu08OnFlzCjX2wYMyrJgQymkvZURI2D
         U0V/M8Pfu16fUkzXorz+mPOkuEtYPP2RC3Jx+uICf7QB86KYnjF1fBE+SFbZb6nsd3B5
         mRQMYjyCOQ1kNQZ7S190PrjHOWDJXGOO7jld4UUN8j6R2D1SdjlJ92o06cNPLz+zp3Fl
         /Ogg==
X-Forwarded-Encrypted: i=1; AJvYcCUKjC+k2ysf1uDjBmeZZLBAUrTyDt9rAW+u+bhWhrMOQmoWvtgZX5Cx3nuKxYB32gj8KGqLz/Lk86Jn3KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynhZ3zbDdPG3rDltcmpogQsd12wqxAJSVKiBJogHTXZPSJ7uXF
	iDIZjh8wGipvDBqFldhnpn8wTFnJnluH0Qx9a8nWLvdOM2eEVPwpvgJe
X-Gm-Gg: ASbGnct3waQrXLUznqlLy4dz+vq1gPwY5h7pmhH1mXaTx/I/c8yPUF+WpDk2iddJ77v
	/028GpXwtyNcj8mpQvT54yPhLevY6BS9cTZ07FmpDmT0y9uCgSe/rEyJOHzU0rD4NI5sGmWF53/
	3rQlXZNjLRO+IrGr3WchEmUg7raUqNJvDkRCuCFPxtsJyIM31o6Nzcnt4DT9e2jS7SJgL+zDRpK
	yPMD/Bu92ZiAZRV+GbGB0wlggWPYq7/S6mF3DGGwrI2EsjWm05ybighsnBRAsViekg1M8kEAj9Y
	dOa462jq0Nme1K2eepijppqkomBuCS98WUk+JJAiVvtSN1+hG5W4+0SKOuuESF4anlm7QB3Z94z
	4oUMZY+VIHp8s1doXO3agoCHeDA==
X-Google-Smtp-Source: AGHT+IGajBZK+02JDR31RQ6JMmB+6pfwgxBAl43j8g0oYxTcMqpE+SRQtHBk9SP1hyukPY/QOxDtpg==
X-Received: by 2002:a05:6a20:9f4a:b0:209:ca8b:91f2 with SMTP id adf61e73a8af0-21d24680331mr373535637.19.1748994192242;
        Tue, 03 Jun 2025 16:43:12 -0700 (PDT)
Received: from fc42.mshome.net (p4149050-ipxg13701funabasi.chiba.ocn.ne.jp. [180.47.146.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb029f0sm7615938a12.15.2025.06.03.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 16:43:11 -0700 (PDT)
From: yasuenag@gmail.com
To: eahariha@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v3 0/1] hv_fcopy_uio_daemon: Fix file copy failure between Windows host and Linux guest
Date: Wed,  4 Jun 2025 08:42:59 +0900
Message-ID: <20250603234300.1997-1-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
References: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yasumasa Suenaga <yasuenag@gmail.com>

Thanks a lot for your advice!
I fixed cosmetic problems and checked it with checkpatch.pl .
And also I fixed subject and description in the commit
as the document pointed.

I hope this version would go well...


Best regards,

Yasumasa


Yasumasa Suenaga (1):
  hv_fcopy_uio_daemon: Fix file copy failure between Windows host and
    Linux guest

 tools/hv/hv_fcopy_uio_daemon.c | 37 ++++++++++++++--------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

-- 
2.49.0


