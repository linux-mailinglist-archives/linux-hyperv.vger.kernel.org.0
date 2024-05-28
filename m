Return-Path: <linux-hyperv+bounces-2216-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EF8D13C5
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 07:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26681C20AF1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC74879B;
	Tue, 28 May 2024 05:17:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA24AEC6;
	Tue, 28 May 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873453; cv=none; b=QRUtcsvEskYqxCwRjrK3/m+kDmsFPQPl5v9W/PZuWArsJl4m5N1wMlZ0IomNK0gCli/gMbv1A6eU9UVbx5T4kyIGBm3qLcjnyHiYsQkqCxKbCwV0C0qsnl48UTZ4ebPKSqb0ZOUlvA/00D3hcOgL17FxuOS6C4p3rLMxrbHxOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873453; c=relaxed/simple;
	bh=IuHMtwTeyqlpqYeXM422lXhrG4rbRJ+Mx575mDzsOgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCC9XQmXFta1ayAeBBBWD8zgx14gnxjSKxbj1JMaDerd81Gry0R760xW9N2vB5pZp35PZ6e6ikJYuWE0NcHzIzky75cKGGnzRmQZZ4OJcQNp+kHU225jWCY2zseLz01dJZlNfmqVCoSS4/1DJJlDY080aMUdCM7lYb2U/mDWOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f8e9878514so281712b3a.1;
        Mon, 27 May 2024 22:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716873452; x=1717478252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwu2A3L+vnaLJrpl04TOxaMqzUnVipp0rU1gzlqdkuo=;
        b=aHRjPyggbSauRsUIhRYDrekWSlTpfgvHutl/JTs1yJdGVpMmNkr0Tf19kizrQHE3ts
         1VSmfDDuF2FMGsimYaxYnHh2EpKMmV7BE4dUaYG/AkkVkizgcLQPOKYLAFvDu/SS9BAd
         P+ecDt6/VGm18MKe/9uVRMAhdgSDlu5osN3wb0aMsk8zTG6Q4kTnN8/ZKq0ZH2TCJedm
         IIRMKoju0j/Kpc3zhgZgvKmo2+qR8PYsRJZ/tjWJja/n19M6sdgBFCvWfZ4JEZULMW6H
         lRYtta8FAXXJV0Vcex4CdkjRi2KNWIBg4xKJO4b+gcRJFKQRwVfCh2g9r01XG9nNrUku
         AEAw==
X-Forwarded-Encrypted: i=1; AJvYcCV3OC5KwH0dz2PhP9Lzq5yBSPXlrNwA/d6BJ8NI0wQVFBbtWvWCdf8iLZ1rLXRw1tqRFTfeLRMr1KWaomTyvQHO1hyeK1guq2dOXPaP4Tqts8tlf/z8Fr32DkzFTVgcrdZ8c65iNyt9IeBp
X-Gm-Message-State: AOJu0Yzx+aoE+Y3ChOn6gz3vAGq+cqOReIfTxDe5U3fnpDUGvhs7TJEM
	RBoS2m51Oc1Y5N3nv3E/VsARVLbq6nOEefQ+S6Ty/oQ0e9VBC4xR
X-Google-Smtp-Source: AGHT+IFxGawmR0bNdr/hoyLH4cc/hCM4hOcXhFoeTTnkd7P16HJzB7T8Q7mkRXK36PzJy8X41oYjEQ==
X-Received: by 2002:a05:6a20:d409:b0:1af:d6dc:86b9 with SMTP id adf61e73a8af0-1b212e3520fmr9309648637.53.1716873451770;
        Mon, 27 May 2024 22:17:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9dd375sm70655385ad.288.2024.05.27.22.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:17:31 -0700 (PDT)
Date: Tue, 28 May 2024 05:17:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>
Cc: adityanagesh@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <ZlVo6bhEvBCIG_1d@liuwe-devbox-debian-v2>
References: <1713842326-25576-1-git-send-email-adityanagesh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713842326-25576-1-git-send-email-adityanagesh@linux.microsoft.com>

On Mon, Apr 22, 2024 at 08:18:46PM -0700, Aditya Nagesh wrote:
> Fix issues reported by checkpatch.pl script in hv.c and
> balloon.c
>  - Remove unnecessary parentheses
>  - Remove extra newlines
>  - Remove extra spaces
>  - Add spaces between comparison operators
>  - Remove comparison with NULL in if statements
> 
> No functional changes intended
> 
> Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied to hyperv-fixes, thanks!

