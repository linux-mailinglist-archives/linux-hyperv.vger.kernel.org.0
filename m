Return-Path: <linux-hyperv+bounces-6859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1477B56445
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 04:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FB717C9DB
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 02:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92B4248F58;
	Sun, 14 Sep 2025 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/tB5jKK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D724635E
	for <linux-hyperv@vger.kernel.org>; Sun, 14 Sep 2025 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757816572; cv=none; b=HKLm270ch/AY2yIJHmyPYCmzyCRUKADEkBY1/8R6Z+MW6Y0wrmrZ5zcXpsvKkpZy32yQH/9Uz7M1acXqvmGuyf1wgP9NkwC6gqJ6PSXKhc3jORDaki/fVGl+aaNqSlTmCx1OJUx75ggjNpEbWAYZk7sv8pnSLnRTn3hSvqFBUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757816572; c=relaxed/simple;
	bh=EX3TyOfBuaXKwQxkn392r7BCMjWDwZpQoG4WIyx3PWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmL5CmZ/WLO9gWBAg+PM046rudwgfWnxCMkFYLe7SBwcCManDDf3n12SIeX+yab++WJyGv1zg4DlZxiA0XVjR0OzAAgyk05oQ7uOGF2nydki3BU/pk6XLcYZ8wSrilVlcSY+6eGFYyQNa9MZy3K4JE6e/Ai2NOUOlFHF5U4ZBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/tB5jKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757816570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EX3TyOfBuaXKwQxkn392r7BCMjWDwZpQoG4WIyx3PWI=;
	b=E/tB5jKKQ/WCPZvMhpnmsx6Z90u8aDoZvhW1SC+PgdWEGGpFRGuzDBd25rBHmwyhWjLUmO
	a8fpc8550dQE3PIL7Dn6Yf3zDHe70UqolAjkv5xmh5+wH3HZNPGiJltat4601VQuC8GIz0
	jc8WarePjNbWG34ofgUg95ic1WoI/fA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-9ghYWB3FMw-2DpCWMYDMrg-1; Sat, 13 Sep 2025 22:22:48 -0400
X-MC-Unique: 9ghYWB3FMw-2DpCWMYDMrg-1
X-Mimecast-MFC-AGG-ID: 9ghYWB3FMw-2DpCWMYDMrg_1757816567
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55f5f436648so2553874e87.2
        for <linux-hyperv@vger.kernel.org>; Sat, 13 Sep 2025 19:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757816567; x=1758421367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX3TyOfBuaXKwQxkn392r7BCMjWDwZpQoG4WIyx3PWI=;
        b=J7jGB662/wPAv3AO5W2cCOIFqJdj7oPrhw9H0LnSOP2QNajCZS+QDCQro+vI2u24lF
         AfPqynwQE/ZJpHkl6OMvuGxMa4QNfpnU1u+DqbEuNnBFBebkUe9TQjJ/5Z84+mj9wuRF
         9bZVybQRNTPr79w9Cg83chKma5VfXUEGzxLiTxcA9lcuEdocHyfONPWy3SggjgO3S6OC
         W3temxdBd8EtyM3Pg8bcaKSRVm2jgb5TOa+4hsPMnVuITbTvqyTM3dcOh8hNRRjuCO60
         7d9VKOyNOrWeqdl5MT41uaDuVYnPC2UclrWcffFXTKZPWaUX2qF9ld9KGktYt3E60agB
         sYoA==
X-Forwarded-Encrypted: i=1; AJvYcCVFgOdyxbNCSmF1QQ+z9Pr4HdSjLxYdPNOGKu/xk6y1CcyS/lsL3XtQajF9s+yl6ZhRCX+8m8ELa4cZUDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknVtgjTBKmk1kfmrQI17O0OxJGpJsyx5NCGb3UgKZz3Rx018G
	kWrEmIp5Hu2KYckFGfXRoJAmdGvxhK+F2Lc5wczneCOn/3VZ5N7Ay+/A9l4LxYQvrmsT53QEGGC
	rerOMg1OH64LPWYvo9dqDJiHnJm97PmJF7epSqNYjbvGvkJJDl8suamrjgwH3BUl6dFntI3wuqK
	iK4nxf4WrqscoQF66rpCxi87xFSc6RvKfWOcjZ/SaOpylPODfFeTeRpA==
X-Gm-Gg: ASbGncthscJyMq+lXhTyQ7qcX1nvUnOK3/bP5wkhgWUZNsFY4RKc+thgcetDfw2TUAc
	J3Dg4qgd/juDWsP7T6TQ3ezifVyl02D2vauQyWwgojPrBoI1GLbXX2w+FjmLO0W79K4pdU8W97Q
	2VWD6tVh6ReoAorolCjxTt3g==
X-Received: by 2002:a05:6512:61cf:20b0:560:9993:f14d with SMTP id 2adb3069b0e04-5704a3e6909mr2406234e87.3.1757816566877;
        Sat, 13 Sep 2025 19:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6LBuQC+0fECjQxQjn7BzUOWmOXhHvsIC5jjwUVw3z05iv8yLPovYye6qdflldAjCnE1SB/JiNJw+Ng3RRT8o=
X-Received: by 2002:a05:6512:61cf:20b0:560:9993:f14d with SMTP id
 2adb3069b0e04-5704a3e6909mr2406223e87.3.1757816566498; Sat, 13 Sep 2025
 19:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913062810.11141-1-litian@redhat.com> <bacbeaf2-104f-4da5-a66b-b8aee2b2de12@lunn.ch>
In-Reply-To: <bacbeaf2-104f-4da5-a66b-b8aee2b2de12@lunn.ch>
From: Li Tian <litian@redhat.com>
Date: Sun, 14 Sep 2025 10:22:35 +0800
X-Gm-Features: AS18NWARZWkoG_VR78fDtIJydZ_R8xlJD5gNpW5l3SKmCv3wXuhvflXEKdZ8Jf8
Message-ID: <CAHhBTWvcd45s5P-TfKBVzHy00jofbgoWtX+z3Uaj+5ZEBTNLfQ@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: report duplex full when speed is known
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 10:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:

> I'm confused with your commit message. You say DUPLEX used to be
> reported as Full if the speed is known. How does c268ca6087f55 change
> this?

Because in some circumstances like Azure, mlx5e_port_ptys2speed (now
mlx5_port_ptys2info) does not return a speed. And thus it relies on
data_rate_oper. It reads to me as long as there's no issue acquiring
the speed duplex should be set to full.

> You don't say in the commit message. Why is Half duplex
> important to this fix? I don't see Half anywhere in the code.

It does not return half duplex at all. It would be unknown. I'm just
saying that half duplex shouldn't exist in modern Mellanox 5.

> Also, what sort of problems do you see with duplex unknown?

There were reports of RHEL seeing duplex unknown in ethtool
on Azure Mellanox 5. The intention is to fix this.

Thanks for reviewing.

Li Tian


