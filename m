Return-Path: <linux-hyperv+bounces-2066-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617468BAA26
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DE41C218FD
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7C14F9C4;
	Fri,  3 May 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ahvunxfP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9614F13D
	for <linux-hyperv@vger.kernel.org>; Fri,  3 May 2024 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729763; cv=none; b=UZzCUKsT4yNl7SdjxzmWzNuwds2bVT1H7w5cJ93r7aOseClxSkTeojRkbFAao1hXD5zToLWk3HrSEr8Y4SLxXVlNx57oIeRcmb9CBBkR06qldbQPf/RLnXep5nYn/tmAX/F0sSsBz+rbjL+zwGyeXjENqOAIyaWlVpHcrO7xy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729763; c=relaxed/simple;
	bh=P+9mJYi0mw/Xi2q+V00fvL0lb6TLMgX/WAJ2ktr/UUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E8hfOOWc+3GYt8X+gZp38khUwAY/HhF4Z580/Mr8+VJKwkVLMqA1QyGa1nlqU2Hh5LTexCCVBC7yMLVsC9V3ndgkqWqtdAJ1z8kVftFWvJrfwJkEF2htvbL19w6PqkRPT/Z3oPN7SUQcyJQPeOtQJkocWweQsZg0xMGO6isPBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ahvunxfP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41c7ac6f635so33038545e9.3
        for <linux-hyperv@vger.kernel.org>; Fri, 03 May 2024 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714729759; x=1715334559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bTlYHX9HW/iMrwFdXDCczbWv+pcOM42X63zZb22zzqk=;
        b=ahvunxfPkR9us0A9CGy+K2b3kofcJVvqi8Ak/EF56eChjtLDgsJs+9LyZ51/zF0sPw
         g/rkJ6u9/t+HfzdwlHp6CvlnTq5/mdJXHLYNcihm3Wz1XQNrxWiWyYiSVlujyQstaDdF
         kd2UmV4m+AM/oIKOeE1kIVPbAzX+KSkeLpz3rE0mHwfquB3iQtnuvvaOmFirZxYJhaCP
         Iy+J5e2phzzfclT9UGqbcc0fKY0y095u7WJSorAd1rC+iCsGJLMiMK37tG/hnketNkkb
         trekxWn/f9S4IbS1JPam0fNQ+EUVHWxh+37rxrOTbmvCMfWsBN7lNfXXqczNNvPRwQET
         vWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729759; x=1715334559;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTlYHX9HW/iMrwFdXDCczbWv+pcOM42X63zZb22zzqk=;
        b=F/UjWHnQrK1FAFl8J36MJs/W042xrDam25oMaWxE3rWclNAykIV/neA8KeLJeAkabT
         +oNoMspI7/w2trDKuMaCqkgR/0TGIa0W7OakUyy9NJU0r7r+vRtZn80coL5RDteNaL3c
         mGd7EhK7O+U0Dgszvv4M0aUt43SS2pvwI62urY7pEZEYJlAtjT8rwbO1tFuLj1ce4pWl
         CWL6mThowZVaiD0b6qlCMCUs2/As1r85B/xmK0E4YBjCmEDirDlEA46TL2wCFkpvo/I8
         ul/Vmwa7BbSKS4syMqS/u+ZRa/W8ub1whIsaNdCQXqGW7GBmmJZtE+VPsxT9m87zqIiA
         /OpQ==
X-Gm-Message-State: AOJu0YxdNP3lzN5j5xQsYl2OSKQ3r4uXF+LfR9zXlMRoy78MN8fVwBoW
	obLmqsekQaJYNi6ieMH/oSIxz5rT4EFcd+pkToMSZ+IAeBqmZHPiOMxCwY5/0w0=
X-Google-Smtp-Source: AGHT+IHNK/eSu3kkHJAl2lYdhqDh2NtM/OSA0hLIJ4EUQ7LM943ZK5EAqN6vWyVzd87D2z7YA0u1ig==
X-Received: by 2002:a05:600c:1e8d:b0:41b:f28a:a11e with SMTP id be13-20020a05600c1e8d00b0041bf28aa11emr2023533wmb.22.1714729759366;
        Fri, 03 May 2024 02:49:19 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:1d:5380:6cdc:9dff:7d8c:ff76? ([2a01:e0a:1d:5380:6cdc:9dff:7d8c:ff76])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041ba0439a78sm8756341wmq.45.2024.05.03.02.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:49:19 -0700 (PDT)
Message-ID: <4ffdf9130493c47e1893f15924d68a3da63dc92c.camel@suse.com>
Subject: Re: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
From: Jean DELVARE <jdelvare@suse.com>
To: Michael Kelley <mhklinux@outlook.com>, Michael Schierl
 <schierlm@gmx.de>,  "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 03 May 2024 11:49:17 +0200
In-Reply-To: <SN6PR02MB41579E87F827F26B3A2E10FED4182@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
	 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
	 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
	 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
	 <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
	 <SN6PR02MB4157C677FDAD6507B443A8C7D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <SN6PR02MB415733CB1854317C980C3F18D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <938f6eda-f62c-457f-bc42-b2d12fc6e2c7@gmx.de>
	 <SN6PR02MB41579E87F827F26B3A2E10FED4182@SN6PR02MB4157.namprd02.prod.outlook.com>
Organization: SUSE Linux
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael,

On Thu, 2024-05-02 at 17:02 +0000, Michael Kelley wrote:
> From: Michael Schierl <schierlm@gmx.de> Sent: Friday, April 19, 2024 1:47 PM
> > 
> > > Regardless of the 32-bit vs. 64-bit behavior, the DMI blob is malformed,
> > > almost certainly as created by Hyper-V.  I'll see if I can bring this to
> > > the attention of one of my previous contacts on the Hyper-V team.
> > 
> 
> FYI, the right people on the Hyper-V team have been informed of the
> issue, and there's an internal bug report filed to track the resolution.
> I don't have access to the internal bug report, and can't predict when or
> how a fix might be made available. But given the impact, they should
> be motivated to work on it.

Thank you very much for your perseverance, let's see where it goes.

-- 
Jean Delvare
SUSE L3 Support

