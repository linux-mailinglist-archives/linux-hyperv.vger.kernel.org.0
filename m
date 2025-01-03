Return-Path: <linux-hyperv+bounces-3571-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CA8A00B59
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8235A164254
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393561FBC82;
	Fri,  3 Jan 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+HmOoAr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D0190486;
	Fri,  3 Jan 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917694; cv=none; b=knznxfoK30YvjklBp+qFoih//BXPJ/Ceofo40QwPS4hrBRz5m7E7KzPrJhUQcAJdJ/vfzydqY0quw9YceVvi15ncNynySXsBKrJxRVcILgG8bJWZOKG/dxM8vDtbJJ4/UZEAnArQ9qsd27fveaqkkzIaul0r7k8mSnr/C7Q8OtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917694; c=relaxed/simple;
	bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAlz9B9QJdpEAxfoPQzylBbDankGGlaK2+PhrIhgNDN4dbONlv0lhFcoAjTuXWBydp0rje2C8qYeTfNJUgu6FXPnnCu/6TfbzIaURdGUIbtx5p43IrDr/jcnGVrlP/6gTgVF7GuCsBla3XHfRlZnhsa08GeYtZzwqLjNIfn4a3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+HmOoAr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21675fd60feso226964765ad.2;
        Fri, 03 Jan 2025 07:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735917691; x=1736522491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
        b=K+HmOoArM1TD8sCJArTD8pfsWu8MpT7Hw0EFLdqqNgTdOPq8OyUBUjjYFl2sOF1os+
         qPFuuNLzMJhplMNTQxxtN0lM76PDuh7fOjNTssNJB+VSXl6/Eh2yjvBLnQAg9FEcb5Un
         wn7pu/FEufS0P4KIS3smKo1bdLSILahNXax8hPM3i48XQqchu3RKVKjAB+2k023lvN1J
         Jp8OJsVd9onRuzpuIqx/Q6Ujfy8Fdyurn2F+mZXKBP9z4TUihM74bKutKfUOFnBSWrGS
         Z/z+cXnJt6y1wFkmQCMg1ZIL6siv7lvRLz9UsJah7zkh0EKhx5lavPZ5WsY1/sswsdUa
         IUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917691; x=1736522491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
        b=Qo/46+KbiYvFKEAX4+Sxz7kfZWhvsJhLGXeiScHSfAbClAfD+NCfFSpsrkdGiFfXqc
         kMdPeBOfE8XmtnwdSThS2AluMXmcEYBDBxgiV0HQRBS+Blc8BNuuvV3NZsfO1RkloWxd
         JRl2Fmybuo1emUC+BwVFvy7POO2qeutGuIGzmryYh7CbfjhLTYIL21S1e0IW4wvErb0L
         qtVcaEd5oajlT9LHqZ+e1K329u6RKLvg8BmCdtP9UPz64WoDfmXy/v8HW30igPYEZUQG
         8pq/F94o8+/jZDSijwsiX+/tr8uhJ+xYNyq+Vzv4UZFoD9ddbzovtHnIaxJkeSznjbkV
         OW+g==
X-Forwarded-Encrypted: i=1; AJvYcCUav9ASIUJZvG7k+Zd7vLcXj0D77i7FhNfSj6TxCRMxN6z96Q9W7zMKKnHMS0Is3ilKvdje+sXOVII/wA==@vger.kernel.org, AJvYcCVDswdH79c/07prrm4GGdoEu7IyZh0J/7v2tnQX5TPuJwB68dK8C8KUATgM1elUHgnY9ueHFfPtZDC0Pw==@vger.kernel.org, AJvYcCVikxCTVTXyRJPjXL7pHqP4upgoIWFuiSCafhc4CLR3WeLCKJiLbFd9UOu1ZW+pcwL/v6wybe08NMf2rAI=@vger.kernel.org, AJvYcCWFtytwM1/+jTv4sd8Zg3bZhYTQETwn88iXcfPg3LEAw73PDDt1exb68RBtDhTJd3G1jJQLJLiwrS/H@vger.kernel.org, AJvYcCWaLbtGZMqn77dltSvKCZilCuQ5MkQTYi2RBqhZC7S9WDr6Hf4TFN/rGTu5z10i5VPf3tVvDCGr@vger.kernel.org, AJvYcCWoWS7aO6JNuFCNnmzReyH2y6QxME3gj1Xqr5aeILm369QtyVlRuWhajJhFl5iGifv+/4ei5tMoLq3EVstd@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTTivV8GyEcsr/FCNXcx31Dr/OXBfFwRcuBh4ma8YcBmMx6qM
	GvOSbtkhp4KiRlSgqNTBf22/IzqDOG5HkqlhpzGA88WsYXbQ/LSv
X-Gm-Gg: ASbGncufP4Zk9743i+bLIoAnPWHrxCbJkk3ispJPCboouFZmuQt+zwlwIlWC0LUIbex
	Fi5dECGH8tOAwHiv6kGF4opwqEhPw/Dfq+AyuHRCAA/fNf1OnSzenIoagDqDt0e9KvdSivd8T3d
	6mf2ohNe+l52i4BeGC6c5/81m/0q3bUPCVCpDoCuGop0CDhC1X496GXy+0M859wpMwDTid+bjfe
	KVB5hJG5kGiBzMYSEbkfCrISiPpX1aqXj/0aQ4ide1hf+NBUcG/RrPdOmWrjkrU03NsoL++N/j5
	AMIZ
X-Google-Smtp-Source: AGHT+IG5A276qFKzsq0vRtD6GevOEebgjRTwKom2lvuNWUTRxP4Uq5vYQN1tUnp8ZXMDpu322FblbQ==
X-Received: by 2002:a05:6a21:3a85:b0:1e0:c77c:450d with SMTP id adf61e73a8af0-1e5e044ddfamr75802412637.1.1735917690845;
        Fri, 03 Jan 2025 07:21:30 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm23948804a12.23.2025.01.03.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:21:30 -0800 (PST)
Date: Fri, 3 Jan 2025 07:21:27 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 00/14] cpumask: cleanup cpumask_next_wrap()
 implementation and usage
Message-ID: <Z3gAdy7nU_-DAxhq@yury-ThinkPad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20250103070229.GC28303@lst.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103070229.GC28303@lst.de>

On Fri, Jan 03, 2025 at 08:02:29AM +0100, Christoph Hellwig wrote:
> You've sent me less than a handfull of 14 patches, there's no way
> to properly review this.

Hi Christoph,

You can find the whole series here:

https://lore.kernel.org/linux-scsi/CABPRKS-uqfJmDp5pS+hSnvzggdMv0bNawpsVNpY4aU4V+UdR7Q@mail.gmail.com/T/

Or you can download it by message ID like this:

b4 mbox 20241228184949.31582-1-yury.norov@gmail.com

Sorry for not CC-ing you to the whole series. Some people prefer to
receive minimal noise, and you never know who is who. If it comes to
v2, you'll be in CC for every patch.

Thanks,
Yury

