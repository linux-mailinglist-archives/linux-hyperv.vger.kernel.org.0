Return-Path: <linux-hyperv+bounces-2439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8B90A617
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 08:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C1F282D59
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC2186E29;
	Mon, 17 Jun 2024 06:51:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A9186E28;
	Mon, 17 Jun 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607064; cv=none; b=Q2vh4U7T1nD3letZfC+ULIU5cXgv/dGXIjzNgYAyOnO08XNnevasCtdkizG4eMdaeiYfLLM8nnvXQ2bp2EX+KLSQ/KHXlBpGhnGDJRafCmdmM2u8XDfEvABjGWD/EkDAx9pPrt3m9jUi7SvtJGQP14LRM9HbKINJUmD+lQINwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607064; c=relaxed/simple;
	bh=IpZp/mW7DMENtlLsoUg2ZdNM2pVMUs566c4uDXHoagY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxHYLx+Q9gXrcc4fKpjXQyi2LBnsOMTGQseWvjjbk8vyAfr5ElibGdXdfHmVZgb3gPtft0nXJ+QhHIOpdM719suw/4ZRiV3XICkHRyZ4VyICHWvKPta+5Qj39cEmBAzhorb8ueeYfZzFTzlhgbKqeoMO1CEcS14KsmlxV+/bgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254d001d03dso1946218fac.3;
        Sun, 16 Jun 2024 23:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718607062; x=1719211862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Sn9t5PlhzvSPMNNXtLlu/LCQ1ItTnvGxpqPZVw4pGg=;
        b=lww0h+WpBDAHLq8no7qVaDNjjUxhzdcg7ylqm9RuflS7qg2L9YuZdeRx5GzchgaYIw
         El5ExnLOkiL6lkYfHFN5Ih+UkaT8siXvfhx/HvDrIMMkO30lAjLIV3rvlyhOZrcQoKvo
         /5qlbtNags+nyUsIALsgXvCIpdXHpJi6caTRZJnLe+8u15aMBP2DqAfcN0b3OOJsZLWn
         b1XUfU5QrSU3nU317zqvFmU3Hc5QuNu11qDTpZgwiu9PDP+14O4O9YW3SIDDJ6SFRijw
         bZLyDJEvzUIsJOmPDnvNPhUeIKakQ34dgGkvp4cGyAv13Rgzk+ciFL8QB8JF8kvMfILA
         7Cpg==
X-Forwarded-Encrypted: i=1; AJvYcCXj4MPQoicd+42knkHVHMXFDByjSsQPe4nhL4kVbmPvZrfBCeJXUkJsAuUsdPKG3QzeRVwJF9E59Xx/jnmJ2ZJfrd8QfCW9NHMeim0FDYhCL3RjrElUqa/7u1MrWaKf2EOf5SUo
X-Gm-Message-State: AOJu0YzB4lOe7v0z5orkrKQPYp9s0fNf60dN1XQG/XZlVLF27PJEyAE+
	cqxV2UmwAxvgUZguTlEZcTxinaRVbmdhWcMOlLx19NKGN0sPXph/
X-Google-Smtp-Source: AGHT+IHfWy5HY4azx7+8jbNehkTLCPbqguVaeJkk7pvS0tEAPCcTnja5wC36XqD9w+T1+d3jfmuBNA==
X-Received: by 2002:a05:6870:e243:b0:254:bb5d:468c with SMTP id 586e51a60fabf-258428c33fbmr10403311fac.21.1718607062413;
        Sun, 16 Jun 2024 23:51:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc925fe7sm7047427b3a.19.2024.06.16.23.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 23:51:01 -0700 (PDT)
Date: Mon, 17 Jun 2024 06:50:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Use mana_cleanup_port_context() for
 rxq cleanup
Message-ID: <Zm_c0ElvAMMelKMz@liuwe-devbox-debian-v2>
References: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, Jun 14, 2024 at 12:19:08AM -0700, Shradha Gupta wrote:
> 
> To cleanup rxqs in port context structures, instead of duplicating the
> code, use existing function mana_cleanup_port_context() which does
> the exact cleanup that's needed.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

