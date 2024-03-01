Return-Path: <linux-hyperv+bounces-1620-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5086DD39
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F8C1C20FB6
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F269DF8;
	Fri,  1 Mar 2024 08:39:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F569DE0;
	Fri,  1 Mar 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282394; cv=none; b=CYoTyLWku/mtXDM1AW7xHEiBcPcRqizobJWDqa8dL/QP8hnhJDJzHnx0ef/FLy0Ij9IOc8m7EMMnAjPWmuCoYjBjHTmNOMbBlr62/hYhH+ZjentxswI6ZJZLlVqDPX/lCWAcljfZWBinkjnEFG9nIUbjNP+lde9IfIx9jx3fFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282394; c=relaxed/simple;
	bh=o0mlrNXeLKOpkc5Xjuqq7wNq4TjeIijIe4pbZVR9UB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRUkEghcXhy29Q2WIUTZHqYoDngeD5ZCE6IBkn31hGvUNyzh/M0RhEx7PgiqGdDo9m+xTtxZQ5UotJETyHABL7SAtsQIa2DBs3asxPKSchn8zUtsGYXx4kQ2YAhXqyOn6DYmn7iZg+plgzFZ61MscKiBt32tknnDB4mNSxVeI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4c62b6406so473642a34.0;
        Fri, 01 Mar 2024 00:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282392; x=1709887192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJYmWKa4DfX6feFb+uTaeKbjx8TkMSnN/NwQNFvZbRE=;
        b=UTfW5kaTkHXxPepUX1q6eIDrRu7Tx1ldkRb6lOfOiJRMry4b//woTwZAspdCWXVQcA
         ezQ13emxwUJqSaNH54nqSu8FHMq57pZtOhBA+mcs67LS7bMC6sirgkeWWGuk0JDMjTtY
         THUbx8kQnqWFLTM6JYRaFOi7odz5AeOd0OdXkl6AfMHQq5kMASujDnmPkPdjdhp7VDRk
         85V+CGJP8JBvfYhqKj1ZnfXJOgJwOgqGKat3rvLNF6FlFEPknfYGx0jb3MBSTXr0D9Um
         oGvDiSzBCnGDd8V2AVtgFoCdgq1x4GoBOVWUWp+aV7ayjvv5B2z2GFfrj9+3fVVn2fSZ
         BaCw==
X-Forwarded-Encrypted: i=1; AJvYcCVhpgTYH8UBZhymW8wIjBTfJh3J2q3/+zYHd13wSSeHDqd8Bi0HTaO9hSjrXFq+y5gPjxrgOBPDKm8GrQY7HgSptD7yMQrSj4jVI2NsRxFOcSIWZGVldKe3L/SqiTmK5gj7E2nIQGkc7kXE
X-Gm-Message-State: AOJu0Yx/hnnqpmA3kGPnS4a7RacfgNgnKeaIJf4N7P3/GVrMl/LtMOjw
	sWhAf9xYNAl9qqdKJ01x+T+9a7LK7vBKE3dVgw2mGP4P1M3/PVVZdUlbyso4
X-Google-Smtp-Source: AGHT+IE5akTd9PJKp7qEJgSOfCMSCAq8FM2gEFm3FAbolB2GR96gZj879xNsPav7pljI7fDl+ub2FA==
X-Received: by 2002:a9d:66cd:0:b0:6e4:c18f:5602 with SMTP id t13-20020a9d66cd000000b006e4c18f5602mr1332871otm.26.1709282392063;
        Fri, 01 Mar 2024 00:39:52 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 11-20020a63104b000000b005d8e30897e4sm2467590pgq.69.2024.03.01.00.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:39:51 -0800 (PST)
Date: Fri, 1 Mar 2024 08:39:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hv: vmbus: make hv_bus const
Message-ID: <ZeGUVmJzqLQD0myp@liuwe-devbox-debian-v2>
References: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>
 <SN6PR02MB4157130171E614FED60FDC1ED4472@SN6PR02MB4157.namprd02.prod.outlook.com>
 <vjfokbfk23ck6ndcxyb6gnbqn7qtdg4ynenvnyhlgt7kwvlwvm@3gvq5sttegj7>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vjfokbfk23ck6ndcxyb6gnbqn7qtdg4ynenvnyhlgt7kwvlwvm@3gvq5sttegj7>

On Mon, Feb 05, 2024 at 02:34:12PM -0300, Ricardo B. Marliere wrote:
> Hi Michael,
> 
> On  5 Feb 16:40, Michael Kelley wrote:
> > From: Ricardo B. Marliere <ricardo@marliere.net> Sent: Sunday, February 4, 2024 8:38 AM
> > > 
> > 
> > NIT:  For consistency, we try to use "Drivers: hv: vmbus:" as the prefix on the
> > Subject line for patches to vmbus_drv.c.
> 
> Thanks for the feedback, I'll keep that in mind in the future. I looked
> into a few commits using `git blame` and 'hv: ' seemed to be sufficient.
> 

No worries. I fixed the title for you and applied the patch.

Thank you for the patch.

Wei.

> All the best,
> -	Ricardo.

