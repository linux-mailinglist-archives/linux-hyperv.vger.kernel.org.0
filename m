Return-Path: <linux-hyperv+bounces-2218-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6B8D13DC
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 07:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD7A285A48
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 05:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC861FCE;
	Tue, 28 May 2024 05:28:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67461FC3;
	Tue, 28 May 2024 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874084; cv=none; b=Q8qL4ddBz8LWo/v9SwLPR40DHtCurXzpDhrnSvwOa8x56Q4e1u7fnqrPn/JGDhrJSB1nmuYIhtjqZSSjB9RBgXmz1+Pdj75yzhmgnF1uIzfedYzHKwfuNbtSTjMVLOMeTy9qGFx2KnxLPBVO+iNEnm7xGH+acgw6TiG1Hj2cg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874084; c=relaxed/simple;
	bh=1R7MWX4+mwMsp8JZCjM+ndoUuOg2Be0WWXY4SVDxvz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4tAIPWvlGruUTw99ZZCJYgGs83cDk4NQEGZFjRszb5P6zkMzn3XCD13RMb63IyXyNycdFwgJHkHEqPZoruFXxOZtt1b00w+tUwH+L3QioxY2pOpN+ZmZWludabT4r20F7C2/UZyKfRcythbJ/JGGTBd7K98E+1MI8NtNKJPmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24ca0876a83so202426fac.2;
        Mon, 27 May 2024 22:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874082; x=1717478882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5kFZAqWhL3uMzjEMOl+7Z8/CsSLGsMcTngYdrg2mHg=;
        b=Ai77oaER1OHm2d9gUIsZbu7u7RiDk58ZzO2Xw9X1lPufEeBjwEdts16slA5WCyNLSG
         a5/lm8o9icEou/ZecsYFS7502ThTMoQB4lWRPFLGm5DbUh75WmHQSBAJ+2CE7yz0XQ9c
         ThQzsPtx0RM9OLhBpV3xmSbNS+nEI3hMWVZXkJovaz5ApluraUxag3aQvCzItOLxuHQm
         cwpNnBXFDacDLjaH6DZZ+anFZk//zX+x0OdCsTuiF6aDDQaUFiij3qk/Cww0lIF09Bi5
         JlFLLU+hKOWew4Khd+oKq9seiyxOGbA63mDSZ8yqm9vzCIaIn7Vc76+b2o1iBi3zdr3o
         zmkA==
X-Forwarded-Encrypted: i=1; AJvYcCWtLalVNeuTFbPnD4S5udPpmWZZHfPQSyqCDBYTz4/yVyb5ic0+yZY7zLlg27XcjSoTZrkkL7CvfHAEfDWh30e3F8FVa6l+iIxjDnw84ALXWrHzR/qBBe+0yDdJNkLVTgXCNniawZmvdvxx
X-Gm-Message-State: AOJu0YyKuzaFJRLOx9GR0o97xlhf3kl9aTCEWSWeik9tQ+NpfJaLXxl/
	swhhdXV72zMUf4eQxu40Tx+Ru+TbXNBdUknXfqeQ7ND3zKzO+myJ
X-Google-Smtp-Source: AGHT+IEeHHigBGaAlqIJLm6IYOPOft1kONei7wDh3Ic1XUX4/4XHRSboNGAD7brfAkJrisGKGPz/xw==
X-Received: by 2002:a05:6870:b68c:b0:24c:678c:4282 with SMTP id 586e51a60fabf-24ca14011dfmr10707891fac.44.1716874082135;
        Mon, 27 May 2024 22:28:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d5b1asm5697366b3a.206.2024.05.27.22.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:28:01 -0700 (PDT)
Date: Tue, 28 May 2024 05:28:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	ssengar@microsoft.com, maryhardy@microsoft.com,
	longli@microsoft.com
Subject: Re: [PATCH v2] tools: hv: suppress the invalid warning for packed
 member alignment
Message-ID: <ZlVrYKHhtVwXq2XX@liuwe-devbox-debian-v2>
References: <1714973938-4063-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714973938-4063-1-git-send-email-ssengar@linux.microsoft.com>

On Sun, May 05, 2024 at 10:38:58PM -0700, Saurabh Sengar wrote:
> Packed struct vmbus_bufring is 4096 byte aligned and the reporting
> warning is for the first member of that struct which shouldn't add
> any offset to create alignment issue.
> 
> Suppress the warning by adding -Wno-address-of-packed-member flag to
> gcc.
> 
> Fixes: 45bab4d74651 ("tools: hv: Add vmbus_bufring")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied to hyperv-fixes, thanks.

