Return-Path: <linux-hyperv+bounces-4032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4FA42BD2
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D9D3A645F
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA07263F38;
	Mon, 24 Feb 2025 18:39:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E75233709;
	Mon, 24 Feb 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422348; cv=none; b=o+0YhmBslzJzr+l1DGmL1i8NcBrwTngCEoNrLwLkIXznotgXhXP+qamzZK/v+JbfKn6B/sr92iScN1M2E2JDl6GgCDpGZDCa9/wWZaO0cJEHSr8ySarCb/3jMMedV/DoHDDuYGeltdt28f2tttCJOT8N6pt1z5ui6TWDRDvQL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422348; c=relaxed/simple;
	bh=eXUvdyPf/NtNHx+25CkbXeCXqrZkAOziv6fA32yXj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZD5ZrA8PhvUGCOeOqupCuYbq7lKsakR6s9NdBj1ggbJThUcIA3KKPgX9QMSmJnUtTrzwJtjgc+QPxYfc4eviCEHjDJFIQ/5sVYw7riXt2SsLKyfALTncg69i2xDcVbml9WUtkSE3Ym+7KEOmNi5vB9s1Tjw/PdUVYGPQAxu8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso9609176a91.2;
        Mon, 24 Feb 2025 10:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422347; x=1741027147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt/Sy7DlK0irgY9udS7HFE4VwcZA6quzBb8BDwFcLpI=;
        b=mEZ+t8ZdELbPn/26PDH5MZOcUnqOhvsGRJDBgQszGfjwS8bGCp83jVeNqPzYLQ2631
         UzyQqOVOgqDO7yYc8+rJT2KeKKwUXFCRem3LR93IVo114xOUWTosG4VT2tRrlvrCeOc2
         gtAiMFsIlMlSwE+fPKQfHq1anfMzxBOZ8FCIa4eIL/ocvxvfAQ45DYMqg6FCMs4Cy/2o
         hokaEvi0canN+8/3fBuXQexUZiLROzLOsoCQBOPWTrvX/c01cIlSFMTc2wshiSTRRidj
         4AaCBS06FgeuZL+VIrt5XLnknMNVSgox4PkGmOwjBojEU8eDmOuuMPeNtNM0JaG2NzUO
         zdww==
X-Forwarded-Encrypted: i=1; AJvYcCV4bZaYqZg1Olz1DDup0HNqT/CKg9OYI8QfWOY8V7M0FHylIs8DF03S4HdN1h9G6V1Nieg3tXbfbbAY@vger.kernel.org, AJvYcCWDOfGqyqe/TNlOXlX1K3pPkSmEnpflTeUz9/EPft68wCuvRCdSfCmx4JJ3B4U0wWTvvulyn/lzcUwVK9c=@vger.kernel.org, AJvYcCXMsKb9JIWw0VMkUIOADkYvvHrZ7ft5kP3QPDeA4vnLSv9q0eb8VPqUrIJQ6jMAu8i9TqGQ+aVXu5jTyr3U@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkHwE3a/nxcYIqOzt27jxPPdjcDTWO13nTCAkJdfiaBcsCCNh
	uft9wERm/aIZ9qadX/dlgyapVjBzaVW1CpPHYjT2WCsTQwMmQ0wC
X-Gm-Gg: ASbGncvC/A+8Vmc6lvEEVLE8aRjLLCq44S8PQ8sxUGgXNx8Rllov1JTVrVGkHpwmfiq
	F3YNGs2Z/w3H5eF/eUMGdBwySXbk/4MoeGflmgGezMBAzsHYecoQLAfuzN6J88MvervbLone7qj
	+u6TgjLPAE23+fvjCbUdzCB0KRbWOclCq73cucjEPzWHbcUxf7wyNl2J6QU0WOAMU9XAiaM7msL
	a0rqAkHHKuLc0+WGVzVn++WQyyRe403BsQIpt2iGYvLSyS2zWLGTDjESy+c4uFjRbeySuI1ieWY
	mE7By5a5g463BYYv7rJUqvLrMbjdxKMzTXqFYGBvsFf0+EnIr5pZkL7DVPN2
X-Google-Smtp-Source: AGHT+IH0NqRh3KmSV94UAB5RPqa0GOhfv4xySiyqAnV/974UzSGCQ04gcpPAfoqTFmKCBD6eiXhA6Q==
X-Received: by 2002:a17:90a:d2d0:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2fe68d06654mr278756a91.27.1740422346633;
        Mon, 24 Feb 2025 10:39:06 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb05f340sm7082464a91.22.2025.02.24.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:39:06 -0800 (PST)
Date: Tue, 25 Feb 2025 03:39:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
Message-ID: <20250224183903.GB2064156@rocinante>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
 <Z6wGdTXExwcTh051@liuwe-devbox-debian-v2>
 <20250220150957.GE1777078@rocinante>
 <Z7jXOJgySICFXbVD@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7jXOJgySICFXbVD@liuwe-devbox-debian-v2>

Hello,

[...]
> > > Applied. Thanks.
> > 
> > Would you mind if I take this via the PCI tree?
> 
> No problem. I can drop that from my tree.

Thank you!

	Krzysztof

