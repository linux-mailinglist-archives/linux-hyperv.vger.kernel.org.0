Return-Path: <linux-hyperv+bounces-2022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F068AD748
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07E1B229C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Apr 2024 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E81DDDB;
	Mon, 22 Apr 2024 22:30:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1018B09;
	Mon, 22 Apr 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825016; cv=none; b=JSnRp6vZC7cFzBDJChPNhHW8T/sNrnHCgcpI459unicG21yYsRpTMyBRY9KaB8Z2mlkbH63S9Ua5KKkOGbWQ/ISYvSzRxPDYG7njUfo43ZttLB2OemlVFVkEQwZ6gAourSta2r3kQasu8rNxcziUXzYVUc0my68gZ/1sCs9g57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825016; c=relaxed/simple;
	bh=h/5p+Yp9YnRhpeUOEpgQGt/BN2aV5ASjlVAiHsObiqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKeIBnmM0sU6iIq3zy81Z7L7qX1S9/CyR8HfFwF28lfGS8aELkaK3ZBzXIqBHQuq5m5lPPgnHF4J/qHNvmEdUhxb8V6aH990VqznzZziTMz1/JLtMAHHlyfZSLzkqWXRT7DjARxbn6N5JPC5ANLKMkTma38cbeRsbFRFR8jc4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3ca546d40so41651925ad.3;
        Mon, 22 Apr 2024 15:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713825014; x=1714429814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjOC5ZmZXzvcKLvcvsZC1TZDMvhD7gUuU0R/uUVuFaY=;
        b=BVOXXjaF3aNOZDubuErY9RWAhUIObIx6UBwDzIDxM9tp+0afavEAKgKIF25rJaJSgR
         r5UIqS+z5oo7Vybp4L0/u1BbGxlOylOjrzjcZnLiT4MQMkldjGx0xxu+d/PTNWV9FjEJ
         TTQvxS3AKTcT1fjJxwlHHAPppKZTs9eIUPN57x2hEQwQYR+mw9EOJX33cjjtmRGOK1hL
         YKmiv4IHQPLG2XMuVKeHFtlDQne8gQtamt1vEQf7eO3W5Abc7nVhaku4jYyFKi0RQlWW
         8Njp85lwj4l6wXHOJ7LcICDq5YJV1tXT0wFgDA5DcJz15hiFKo99g+xZ+88CQiuPrIJR
         dGBA==
X-Forwarded-Encrypted: i=1; AJvYcCUHn9xjoSVdzpZhbcq7pt7pMOn1/wpgh6tvVFtTAiHoX8Wgj6TipB6Z2tOJ+j7pw+Zj+6Ucw1U+bA6BySvbx6F42PkEbWQoxEmEum1juTQCpt8lw6zJcZ3JkEdmrciEW5SZLGdlo7SDvUus
X-Gm-Message-State: AOJu0YxINLo4i3n+Izi64mmU68+V40/vLrc4oBqrN/Z+hcT0S+xgeCPm
	O24c6GTzGiDOIfUqCjxAdWnxr3CJ5jaKHkNS5PtrPzuo2VBwFPg0
X-Google-Smtp-Source: AGHT+IFo3QDoegBEmAE7l4HkVTl32gEo6ootHLTr1Fi9AguWjsU+RKNkSpbYgX/G/jKPUzlsX3G0NQ==
X-Received: by 2002:a17:903:943:b0:1e4:3c7f:c060 with SMTP id ma3-20020a170903094300b001e43c7fc060mr15213580plb.66.1713825014194;
        Mon, 22 Apr 2024 15:30:14 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id kk3-20020a170903070300b001e3d8432052sm8623012plb.275.2024.04.22.15.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:30:13 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:30:11 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ernis@microsoft.com
Subject: Re: [PATCH] hv/vmbus_drv: rename hv_acpi_init() to vmbus_init()
Message-ID: <Zibk84K4WU_4Wm9g@liuwe-devbox-debian-v2>
References: <1713506209-937-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713506209-937-1-git-send-email-ernis@linux.microsoft.com>

On Thu, Apr 18, 2024 at 10:56:49PM -0700, Erni Sri Satya Vennela wrote:
> As the driver now supports both ACPI and DeviceTree,
> rename hv_acpi_init() to vmbus_init() and
> change comments accordingly.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Applied. Thanks.

