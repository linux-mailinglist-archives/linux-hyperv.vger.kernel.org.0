Return-Path: <linux-hyperv+bounces-3979-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD32A3DDD5
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 16:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234E53B1AC7
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7A1D5CF5;
	Thu, 20 Feb 2025 15:07:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE11CA84;
	Thu, 20 Feb 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064076; cv=none; b=QkA+qPBcZ5MSngQkcSltAOADDTBB/08s4uJ4Io2SOX31seTHEj/s2mbDEGGOzn47rqAzPT0/9rLMq0dChJhl50ZThQbZ9DbBmBl2JPzTnlHN3ITaqz6k9qshfj8TxICU2YZkmiBhsBvvDIapQhC+S9AktriW/3Ipf1j0op7pDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064076; c=relaxed/simple;
	bh=Q8WEkvwHHessGuvlowsdBEUzNKaTWW8d7YmlvtPhrtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei7hKKchmIn8eV5uR5pXUEVtbqr1Ckv8fCqVb3koJ3xwbFjfGBz3NXpLWLisZiuXzMjfUft1C/9AukgPBAJx78THkCY2YEtg624TaDx0x0jSAJwx/vYCsg52Zekapdsuy6aK5qbR4RnlSd3j0mnCLw7MP/4CTKcB7aDiRy7N7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bfdfb3f4so22970825ad.2;
        Thu, 20 Feb 2025 07:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064074; x=1740668874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zaVPeUyMK9bsx44Th3FOFRswEjNKZoLf+EXZU2SqQY=;
        b=VyefNNeTpsNmZcBbYpTSQqpuA2k5qMqCh7Nq28FbP/UONWH/2LdMMVZr7UE0libmPe
         DxeTQjXwb3VQ9+hUm9PgnxZXnb0q/3kEq8c1tPldLTaiMEUWFHodd4d2YCGVWrtWhaam
         TwFk3FB+JTpO+wEdhMM9VmQEG7rreCIi/cqIS57QK44wHyKlUkJxUizSCRUZJJ7TZsVU
         7s+m5ohWMV+6eWuhgpTgCdn4DNx/bpbELGIDhtYW48dn9QhsJjY5nfNqrmUvza+61Clg
         69UoLdywtcHhZwYyGIuJGbKfcveU2IvPohCTztJpMpS3KrPYuXL9bl13IQ+JmK7xqh44
         b6UA==
X-Forwarded-Encrypted: i=1; AJvYcCUIDiZnNLpP3H7jUa/pRIpUThGHs83jV932iikFCwx0fSoQlbEVkWos+8pq9+QDv8VhwqyJN0e4wLCDxcSP@vger.kernel.org, AJvYcCVov2uhc84XgMA5cJmL6CwAcHiJ5y6QfqSbeV5DOZm61HXO/1+ZIzli1jtIO849gCPj9BQAnhzFcN4A@vger.kernel.org, AJvYcCVvTfzX3+smEc/p5izCRBBGhH2m7cJ5wzqFyWvx8asSjUx+trOEbJL/GdDAWnN/t1Ztd0ZcVVy1iFIge0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGxfcdibRD8z54d3IiNv8CkFstLZxknkN9ElDtWmVY/2wdSiQ
	+0iq0fa1OgRv4qB5Zf6P4DdA+yyQzWDKPmtAwo7cm+9Ud+L8EgFf
X-Gm-Gg: ASbGnct19Q3D9qPLjCo8fDLys/cFdc9kuXP3yYsZHSSV/jOxWJW72KoFZHsB/ZUesf6
	wWw+pB4fHR6wiMCJEcxWckqUbtcTyFJ8SVzeF61OGjis6p3F9tiVw4GbO+56x/H6/FUO/EGAYEa
	rufoew5AYO4g7QOJvrLvOAJRj0i/lm9/YYowQopS2OBl+MbAa0lZDhNzkGeIlBMoRV0OKNCXFJI
	X9K/jxUBdg/j7CvdOvsmHOXt7D6U0TOPWPUSdHcn0CaxHyHhQd7iMIVeHOxZWbFjsQR7ZKOy0EV
	AOxIMhPq0a3VGPmO0U1Z+J4KNoWvPhQ75iIclfhi/HlbJk9opQ==
X-Google-Smtp-Source: AGHT+IFm2Ivs5vcULV4P1VfVqtTlrqG7JCOFqoTsqB+BfueO5ZgT/GH3+gtYQIP4/Fnf/Adpgok60g==
X-Received: by 2002:a05:6a21:6191:b0:1ee:67ec:2279 with SMTP id adf61e73a8af0-1eed4fb2251mr13720501637.26.1740064074600;
        Thu, 20 Feb 2025 07:07:54 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7325f063782sm11326728b3a.148.2025.02.20.07.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:07:54 -0800 (PST)
Date: Fri, 21 Feb 2025 00:07:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
Message-ID: <20250220150510.GD1777078@rocinante>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207190716.89995-1-eahariha@linux.microsoft.com>

Hello,

> The VF driver controls an endpoint attached to the pci-hyperv
> controller. An invalidation sent by the PF driver in the host would be
> delivered *to* the endpoint driver by the controller driver.

Applied to controller/hyperv, thank you!

	Krzysztof

