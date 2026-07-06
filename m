Return-Path: <linux-hyperv+bounces-11840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZEUrG1nxS2qudQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11840-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:18:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77471464F
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=SazfPKw5;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11840-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11840-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1F43300D799
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2026 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B127422553;
	Mon,  6 Jul 2026 18:02:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90441DED8
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 18:02:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360933; cv=none; b=VFFgpiR+oZAZRXshW2JIo8Wxy1o8DCr/d/wJFoflfkjAsiw2P9JsBRQb5oFrPhVePzjoNfjks3M/MuMd+4UfUvTWTAWC/xtFkYA0uZChOiWXYEgCyyEtpaibGtBft7z2Lqdzo1he6BDqfU0RUPdz15aQfryxj5LwxZZpaRYwGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360933; c=relaxed/simple;
	bh=kXDlM4ALMMZ+goUgzxjE8iSzN63pj5SPv611+8XFIGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsIe8NoMhFY2uTvYtQhI2w5cFm/ds2Ewvovhx96BPPXhBKP5rZ95+UzGoavMFZA9q17racv0s5US2Ia1/NCDK4enwRllfTS7XX9c0uTtyW+9vJwyV3+3sEM1bymY10RhocAO5gQ/q7nRmvqyQRAHv60SUbXkwspkmYIK4gYwWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SazfPKw5; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8f18d92172aso46474356d6.2
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Jul 2026 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783360931; x=1783965731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kXDlM4ALMMZ+goUgzxjE8iSzN63pj5SPv611+8XFIGI=;
        b=SazfPKw5hQYTg9bVJDJxEiMKZV1JBN2c83Jh9Wiidbl6iqOJJBFCWRI4jWimKnfY13
         teafepspQADfGRWblUzKOGf1QNE2Yr0WLmGhqe2+KZ8o11DQYPO0jlAi7rIAxPXLOnUa
         zXDWcmnZntZTSPGBfmPj3FMwjfni8AXvVq00h10UItFUMdq0Xs1T2BTV8aChiUJDZIFC
         utzw9jNpTbhQcDxVzKSlC/yT8fgoxTzZrHd/vypd2YdWBhYRtgjnSO/qOkqMUqRKkB/4
         7/Alf79DViSMccTpXF7ynnJf8FKlNXnrOfx/f+Mu2KkUpK7CiKSTkvfHrxPV4AwkgKmr
         PBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360931; x=1783965731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXDlM4ALMMZ+goUgzxjE8iSzN63pj5SPv611+8XFIGI=;
        b=dcBqkFisivsUWU1NEC+eNhNipLKKy0VWrcJP/EyR/95deoQTGApoD92OQ8wY4TvKHb
         fw9oJpoARQ4jr2hP0k1Hwh3Jlj2o/OnUXtd/+/bJbqAksXuZIGb66U5SPIELwHviUA4W
         hRF9ekcLT1NxNuYgBvWiVFtbhrYZGDiwHyTeTTpCY+p+ootlzsKmZ5I42F33Rii/fv03
         8FYUJq1thO8zc105C65Koi5gQcVirRtTp+bU10OJffCkHm2b+uu9TFUYUhRRfagihSeB
         jJMlhHc6i/ZPLn6pngwT0FLVLIps3OuC+9Xao/756L/pE21Jb18ayJ32l+rvFM2eJX/k
         6fkA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ojyA4ySQNJuMHXlDoEeHGoUhhHg47W/2jjSE8bLeyfOvNYnkuN/Y/3QVM/LrvsGE4gS+MbEbNlldMrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/yyOt1u4XlyGklQC8OWdlkirqnJYpSJjAGmUR48mzWsm0r/F
	LYYt5kHne8lpFO+1txfrXziFuWSDWJYdbd0k+TK/fVoG7EhfnydFkcR19Pcqw6r/iIM=
X-Gm-Gg: AfdE7cnTWA1PhV+1NJx5cLZ9qUliuiRXspaaJBMclEB30JaIMUOTuNwHwzfxY2KCX9R
	yoU24h3YgyUZ7SXumlAAYInaep4VN1b7SeBNmIZEcelbnoCTcyqxt/3xSRdY+aGr62sh1Nn5PPb
	RIj7GURFMPU6fiC/sQ0W6ahdkPYusP5tctN+mIadx/DLSjuGUIdF5PT2NwCd2I5p861hD/qq/+q
	z4rVwP6aibmI2UnJaulDhSI/ME+LjGvXZ/YPKf0hotOvylBgTRxkbPISD7syP41friYTvD+E045
	MQeZyGXZomL/VZ1oZjMGZ1azsqzWb/j1Qyjq4KZ4KUMW9DGIsj4CHvCLKeNODIo5RDr6XiCr4hI
	8lFw+UOJZQl9UJ5X1ofGIPNT8/4Az+jEykWpJYTlZ2YiFCHIChKIJrXpLMUBZizS2Pv1rvtw=
X-Received: by 2002:a05:6214:590c:b0:8ce:ca7d:b099 with SMTP id 6a1803df08f44-8fcb2990a80mr21004896d6.18.1783360929999;
        Mon, 06 Jul 2026 11:02:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e371f44sm150118746d6.2.2026.07.06.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:02:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgndw-00000000dS8-35OA;
	Mon, 06 Jul 2026 15:02:08 -0300
Date: Mon, 6 Jul 2026 15:02:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@kernel.org,
	corbet@lwn.net, leon@kernel.org, ljs@kernel.org, mhocko@suse.com,
	rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org,
	surenb@google.com, vbabka@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v6 2/4] mm/hmm: add hmm_range_fault_unlocked() for mmap
 lock-drop support
Message-ID: <20260706180208.GB118978@ziepe.ca>
References: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
 <178336050736.504354.6052508493877924780.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178336050736.504354.6052508493877924780.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:corbet@lwn.net,m:leon@kernel.org,m:ljs@kernel.org,m:mhocko@suse.com,m:rppt@kernel.org,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:surenb@google.com,m:vbabka@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-mm@kvack.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-11840-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD77471464F

On Mon, Jul 06, 2026 at 10:55:07AM -0700, Stanislav Kinsburskii wrote:

> +The caller must not hold ``mmap_read_lock`` before the call.
> +``hmm_range_fault_unlocked()`` takes the mmap read lock internally and allows
> +``handle_mm_fault()`` to drop it during fault handling. If the mmap lock is
> +dropped, the function returns ``-EBUSY``. The caller must then restart the
> +walk from ``range->start`` with a fresh notifier sequence. ``-EINTR`` is
> +returned if a fatal signal is pending during retry handling.

It doesn't make sense to me to expose this to the caller, the caller
isn't holding the lock and there is no reason to redo the mmu_interval
at this point, so why not just loop inside hmm_range_fault_unlocked ?

Jason

