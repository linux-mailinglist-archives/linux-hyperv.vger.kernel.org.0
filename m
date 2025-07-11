Return-Path: <linux-hyperv+bounces-6191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A0B01FF1
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3251A460A7
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B32EACED;
	Fri, 11 Jul 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IId9Hb+A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30A2E9EC2
	for <linux-hyperv@vger.kernel.org>; Fri, 11 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245901; cv=none; b=OPT6GAgtWUScM7U1n2UXA5HT4XO579EFCyp2ORhY5VaoEIFZ5aLFQswi3f2zNhvcQJB3XuUNB7fdzNjTYf4LDnMuEVTYpjh8EkBiiKYo+UNwEOJPQ3MyyDwDKmYKh3Z4BAc2IWaFfxPVfLC4AAKd9c9Hj+FTR7rAG3gnwvfLXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245901; c=relaxed/simple;
	bh=Sya4IZecYhktVtfCvUqQruAjlPK6WvHM6B90iSMN2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjKj1/HcLERx55EGpj2iLhZX26pEQzvuYSPglcXarxl1MaM2A4FZ+zI0EUb/ZYN377Pq9v0n4j2EZdWlOkupSDYAfXNTYxiBV351/KFwtVJl5kX8/mHbPIbmLcDaNOwv9Bsy2uaWPA3j54qMjQlcjjeGdIJgUxFq1CNU0oWHNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IId9Hb+A; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab3fb340e7so3370581cf.1
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Jul 2025 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752245898; x=1752850698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xpLl3JD2OmKi675SUm1Nkl7pyLdcDBPv23avyh/9xc=;
        b=IId9Hb+A/p5KLntqBo8PCqBaELxv7TM8Xq5Wpq4NTGR6uTZyDHdUq6jqKU8zq3PlgZ
         35bWi2+DQHYJlvFghQlFUTxlkg2lyO/rH58DPHm8vQESsFtAJtBJ5t/oIL+2ZuXsuIFs
         RvBUxRXCRGZKM1M/Lxo+gpXIp+o/7pEUkTqEQ15I4kCF5yw6LPU+M3D+72DCvUc8ynde
         YYsxh1oYDPvl2CMN7LtpRdb3OW89ymK3nTtbmLNyA/LF5G4tufQYP3fHtq49Xr1v5RD4
         k5jEJeNREiAV6ZVRi3FUP1zYAVw8SefwV+3XiRh5lIj/u66tWNpMKpPTata1nWjzJQHY
         xJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752245898; x=1752850698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xpLl3JD2OmKi675SUm1Nkl7pyLdcDBPv23avyh/9xc=;
        b=JCM8T+I62t4lEIq5XSJwG10I3Be5OyCN/xCNS514ZnkB6D+laFOd9KN49YnqIaLz4D
         81iuzM+WZyQBWEyuomDTcHu29L0M+UWg28Cj726EFXoMeXKjRMJm4dbTJL6X9WcvvyuC
         lFh+JyV5k0JAnVfvV6Y77qu0ASnT8lGDFyXPGUH1GYwJdolSn6nMB4wdfNDEJjo7Xz59
         fDOxQscwm07LhEmIHC7ytBkFXjFPQ4l365x5OZRjdk644dWH3G8ehq+Sa+qY07oOYRJY
         3QqWoIc9+s+39bUvJUCWec+btE9oTvHGpN1jVFNySYHcBzWvuLDHf0WTmFwX7yRjOjyj
         YpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdiSBlPduF7fnFHGxYFS+n5Hg3iIg6E6QW/EOC+ZUU0D7HGPV18zMZXRCleD2p6olAYDJwWnn6zOfQjUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJ9fLQfA5GxRvk9/m1rqtkxKKPbMxlzzWnlb7qiGV7mZNerI5
	6BwUkFuWz3c/+ZosQJqqy2ASp044wBIaj/z365MbfZzFmwrzJzU0FsVKkeaAPyOrAOE=
X-Gm-Gg: ASbGncvP3ZjVcSqcvDyOwGvkk1dtpx9SFvsXVXKEoHG6aAubzVtRdIPp0+03D1v3fTL
	AcIiuVskOr7oylQKoygrmdWEe7/OYWW6c8o0JKn4PA06wSjvgGbd+ohSri1+uV8owEEWjGvsbYi
	6dKk7wGvL2I64gXkC3DwcVvcaM39ysBs/bBRgVy5JRUvC9UxB+e0aDNvsENLVl2ks1yMAP7/+pF
	+Azd4LVSpx0Ac9YkJCV/QYvB05wkGYFpr5b0lIeQ6v+OwZEAz02/mZJmr6v6GyZezFi1BRzlGUm
	O85Q2ncpkfGvXCmqc39/tuNeSJQtuf4lU/QBAyn7+PnoJeOwhkLBhpOmpoYonajM1mM49tJy1J2
	7mFX7WU4qTwKJ2w2FmSTs7dOjwZAL1Li0prZ2Xz98L08vpK873C6qbLh5kSr63NDetedll7NR2T
	A=
X-Google-Smtp-Source: AGHT+IHL89Heh4CdilUF5hG4UKz4fj2b51QwxhHDN537ydTZFAi50FvMeaNyPPTH09uspMZNgw10pA==
X-Received: by 2002:ac8:5d0c:0:b0:4a6:f6e6:7693 with SMTP id d75a77b69052e-4a9fb861a08mr57831191cf.6.1752245898221;
        Fri, 11 Jul 2025 07:58:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc1b784sm22118351cf.12.2025.07.11.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:58:18 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:58:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF
 before open to prevent IPv6 addrconf
Message-ID: <20250711075814.1f5ae098@hermes.local>
In-Reply-To: <20250711040623.12605-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
	<20250711040623.12605-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:06:23 +0800
Li Tian <litian@redhat.com> wrote:

> Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")


Should be Fixes: tag since the reference commit caused the regression.
Yes, it is a way to blame and track.

