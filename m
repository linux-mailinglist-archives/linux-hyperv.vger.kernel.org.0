Return-Path: <linux-hyperv+bounces-10109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILVzJeMh2WkqmggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10109-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 18:14:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2D03DA35D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A05563006089
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2026 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720B3D348F;
	Fri, 10 Apr 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VuSfqimM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCE3A3E86
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Apr 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835810; cv=none; b=W++3IVlGEOqwftpH/WyjCs9wTm3ZJ1eDCROrvwutks/+agLY6gc59wHj+wfklMHvfjmv3kE3tvZZIoWATDO2uhQCRIIbLrYQn6rHq5KltG0KwFcW/rtsOd870q087WTrxjM/0iPZieNheAzgU2JIIpDdmE4j/2VALY6mO/K8y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835810; c=relaxed/simple;
	bh=15c4ee0axhyY9xh/M09tb/QEQ2DqSdy7iBQH6Onsn94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpsFwjc3XTEBORt/K0j6yhwaY7YDtYzH+HftMYOoVz8OSRMRHaLKgIvVg0X5+prOVWzapVlFbUvZOmlKj1s9ty5akhAoZNxnRBqEIqdl9Q0YEF+fVSHqZ7eXMbuuHusAQA+oUMTxcLfv+Kvv1uG0E+YCRnm7ggnkH7KbzmvJImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VuSfqimM; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d68bcf50fdso241354585a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Apr 2026 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775835808; x=1776440608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=15c4ee0axhyY9xh/M09tb/QEQ2DqSdy7iBQH6Onsn94=;
        b=VuSfqimMCZK642rs+v4jbhfAalGWZ1ko3jrnQrP0Hmwe3J6KBNE0VMWXPO0R9BCWcR
         djvQbOzYVJ75uzuM8VDI0Xsl+i/rJb60uY/hg/na1X8+aYrVQ9TUOuuIrBHu/U/bsobq
         JDUBckPVm60udk67/AELLoxZwbj/iM7EUsrGa+57s1X12HBJPeSeKPsv3n6MKYALHkLc
         Vl8kt5EamiRkX4LNuMUSbhVV3rT1agQF4e1cmWdyijO3gNtH1Z39QUKWAKQVzZ55cO++
         S8/oBCkWXS0JVqQlMZ8FTlPXePXMudCUD5OxEpMuHRC7328WNNDbBvsMUBu8WQFQIoj7
         dlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835808; x=1776440608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15c4ee0axhyY9xh/M09tb/QEQ2DqSdy7iBQH6Onsn94=;
        b=NFzid7JgGcVGgDDQwxj54w4gSEB4C8pmPtJYGYykLTOFXSqn2n2UCw1IX2n0G/oDg2
         EU59FTl8g8s3qKNSN8M+v40/BR4FBU9ZbS0R+Ndn7FBoimGUAdTCvdfGJP/qu+46qgUe
         QryjhGm+BXZpCyW8g43S7mKRF/T5JX9aezZCy3Hkm7HGnXhqI2UGDwC8OVEV4XJc1f6v
         Djnc5MAt/Q0/GjK4MXjruRH8CxXKEZWK7EkclrM1rorcxPbysAISHJP1zFMjtZXmkeYp
         77RhI3EXpBSt02CoNNfbPIj07Nkp1+CciHkhFYQRLr2Aov1IhdDi7cL13CKZR8/Zda0X
         Rolg==
X-Forwarded-Encrypted: i=1; AJvYcCWJr9kQMxecCEodA+DzDTlIWcRoNIBpV5gyTjNr7fj1smN3j9DkfQEfNBAGZk1dtq2Vq6nq3SMk0bHeu5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeElDNRHTdIOWGAoaOVNfFVKvBDE2aTIhlq9LdYTBkp//AfeRC
	1yk2QGTvWjsggCz7p6eMoO/rXYmKJxANxLmDuboB6a8/lzKRXHzqR6N67Lrn/RiIN8A=
X-Gm-Gg: AeBDiev/EuQmV9FdGTGpIR1ai5bUP1VDOG+qO/5g6Va+w5DCfmWLMcdBxJl4CkrtXXi
	HVueWBQaByLdjfImve3SDoCdKmQSQE/d3LZQHER28EhhiVPSgWzDrV6/CKbqWAqJMbaBPUhVybP
	dk/z4W3jGiZV7qoEa8BY1/Z4dJU/FDmeupCAybZylerQkjV9VQ/d/b7IHk2NPWNCXzgQfIb4xb6
	fSa7seF6IL29gaZloz8G78D/Fy8eQ8VgUF0EwaAdDbSdBtnucwu6DzKyNDo1to9uG90VkN1D1bf
	dRNAeUl4gWNofgLRRn4YlkIGw5IAK7eiZNqq191iHGl8efir+DTMWE43QHSLdV2GeSpYza2rG9U
	Md2zS2ir4B+M6uU9T4eSAZHRmvgxkkIr7yd0KZxxdUGN+Jf22NaDkaVUDPgMmy11NdlfyTl4cnD
	BHhN43GcRHJIkqzesJVllwnQHQ3F1IvE9zbeiF2EdcHPffCYI0P2GaJdHuqdtp7lw3FP6moA==
X-Received: by 2002:ac8:5a53:0:b0:50d:5a11:1a8 with SMTP id d75a77b69052e-50dd5ba3952mr57073421cf.25.1775835808064;
        Fri, 10 Apr 2026 08:43:28 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b49dsm25682421cf.6.2026.04.10.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:43:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBE11-0000000EiT7-077R;
	Fri, 10 Apr 2026 12:43:27 -0300
Date: Fri, 10 Apr 2026 12:43:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260410154327.GA2551565@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-10109-lists,linux-hyperv=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B2D03DA35D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 12:56:39AM +0000, Long Li wrote:

> How we rephrase this in this way: the driver should not corrupt or
> overflow other parts of the kernel if its device is misbehaving (or
> has a bug).

If we are going to do this CC hardening stuff I think I want to see a
more comphrensive approach, like if we detect an attack then the
kernel instantly crashes or something. Or at least an approach in
general agreed to by the CC and kernel community.

Igoring the issue and continuing seems just wrong.

This sprinkling of random checks in this series doesn't feel
comprehensive or cohesive to me.

Jason

