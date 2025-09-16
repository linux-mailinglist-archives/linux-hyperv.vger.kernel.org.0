Return-Path: <linux-hyperv+bounces-6883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3CB59770
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E93BA75D
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C4313267;
	Tue, 16 Sep 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioam/oqf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95A30CDA2
	for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028982; cv=none; b=c/H3CzHglsR3GgP6dp8B+C+MbRYBM4cezSuI1dTh+2GoKb5DFBNzpe11rB8CSiQU637GrDDH5tH6KhKbbwmX4t8jti6gCO854TQDWFe1ex+Y2flTUpWfZ9OjX8/HR6aU1QbYE8IDNMIMe0A7jZmEAMREUL8+8DDP4pZV+zQZ6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028982; c=relaxed/simple;
	bh=1IguQoOXA8FrFKBeUbtVgSy6pYqlTs5cyzQln/TF98I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jFIUYYrq7XzG60Ay9+xi3zoiy1+bZDj4wf/BYBSOcSUn+HycDnmee2JW2vTEAu7laUh90dMO2lf1H5LnAR0CIr7tEOANgpefwppQpf1iIdV5bkx8oTWjf9lRWz/agOFtYaodR7WJYdXtjbVU6e96kN4U2ijhouKsEIl/f+axTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioam/oqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758028979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oP4iLXlqo17dgLSrgkQgZcHvE5Do89KtwinnL3mfgo=;
	b=ioam/oqfK9PWUJUcgXrzHoH2jakDC+YhJHx5ffPzIvhSaSCNv6RNjCgeyAoh3ZBG8K16te
	M02DRFvSou+EstuGZX/AnKpJ1s6Qx4yxxzuYHKPzXiqq/+3WKjm8/Ch9Nm6wDazcdoBCzO
	hAarNXM9nMgRYnmKAnMbYEs/aNYd58w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-KsTmRSjFPnmUJafQeApJlw-1; Tue, 16 Sep 2025 09:22:58 -0400
X-MC-Unique: KsTmRSjFPnmUJafQeApJlw-1
X-Mimecast-MFC-AGG-ID: KsTmRSjFPnmUJafQeApJlw_1758028977
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e8c4aa37bbso919006f8f.3
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 06:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028977; x=1758633777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oP4iLXlqo17dgLSrgkQgZcHvE5Do89KtwinnL3mfgo=;
        b=q90qYu+7PCxlTjymbYRml0Wq5K7PRgN1FNqUIPLtfDjUp4Zm0OeZdRmoqQN1kz+Drx
         Jz8CaypCoAkDwtvRWUYj955TFhyzSmgLQLg+dsuKj0EWhkpKWJp7N7O0wTimp+LMMk83
         OZaIunRRmSfWwQQzJUF6lyjrE6idtBwGnopIiEYwBkzFjGkB0MJje7Rb16mTZAcUL2oC
         NOzH4rrUR1A8knRRFQKeUsaic2WarHdhQBz702QBeRMXejxE8P7ux2ug5QIGsPTd5XBS
         Bte2SjhTwUP4icEgLMh/utriGgcu9uWBQHu/ykjnKylnYnlQH5hFiarJYCTZByCptYNi
         T5fA==
X-Forwarded-Encrypted: i=1; AJvYcCXospQJe7iH6/FWV3EcapznRtTb/2r1seG1wRCOkiVLoYyKYYjk4nVd+LbVINig8XrdidJ2YgZluCWslVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAT50UnTF64TL1gcFLPY2bivwQbVm7WfJBQaqxe+h0CKWO5irE
	BxUodTyHCHxJlMYNhQLv8f443sFGke4GRC7In6K4c3CmVPJY2ROC+lErBvUEA0yGxxEKfZ3pXIz
	4bY5VqOgYS3tCrqetEz0Iuf9W9LVK6kceikic2ayHvUAhO8U7SnskXOK8DPw0v25/5Q==
X-Gm-Gg: ASbGncv7VQeY3n1m/vGMwwIUDSghyEXeDZTopb+SGNAvQh/j0U2cJ29v6klGP3WErYz
	hoCOonUUBGTZww2T4GvHDqZ7wCHjt7gVtk9K1zL91GwlMQM431UxTqINSWQ4l3bZSfu8z3Dq3Dg
	ghtZhX8CjdlXT803Dv9ANFNbVZQwQV8WiqvD/dF0WpoT9078cXAy+5NoshJZHeZNdhc8GobHIhx
	IXvpha9/hrV9aop8bWGyrsoKzCGPvEzOOgOxfXBaIqfMktm2wgHoMYt/EpPXWuS9yNboNa9NNu0
	Wa8LZLu36VyYQW9kgveUEZr48VraycDmBVqvotXTiPM0znJYnxu+O/TnaJ62ycypYjbVmM75YAB
	tEJ09bfW95bEO
X-Received: by 2002:a05:6000:1a87:b0:3ec:db87:e88f with SMTP id ffacd0b85a97d-3ecdb87ebbcmr933075f8f.58.1758028976899;
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ZY5gUmJ119iAt2SKTgVZxX4OPWSH9fLEx7WX7rL1qK5MveunydRadRnPWxfpxv4RDz+i+w==
X-Received: by 2002:a05:6000:1a87:b0:3ec:db87:e88f with SMTP id ffacd0b85a97d-3ecdb87ebbcmr933036f8f.58.1758028976410;
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e96dee54d8sm11914722f8f.12.2025.09.16.06.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:22:55 -0700 (PDT)
Message-ID: <0b5b0d1d-438a-4e41-99c8-a6f61d7581b4@redhat.com>
Date: Tue, 16 Sep 2025 15:22:54 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: mana: Add standard counter rx_missed_errors
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1757908698-16778-1-git-send-email-ernis@linux.microsoft.com>
 <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 5:58 AM, Erni Sri Satya Vennela wrote:
> Report standard counter stats->rx_missed_errors
> using hc_rx_discards_no_wqe from the hardware.
> 
> Add a dedicated workqueue to periodically run
> mana_query_gf_stats every 2 seconds to get the latest
> info in eth_stats and define a driver capability flag
> to notify hardware of the periodic queries.
> 
> To avoid repeated failures and log flooding, the workqueue
> is not rescheduled if mana_query_gf_stats fails.

Can the failure root cause be a "transient" one? If so, this looks like
a dangerous strategy; is such scenario, AFAICS, stats will be broken
until the device is removed and re-probed.

/P


