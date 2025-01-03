Return-Path: <linux-hyperv+bounces-3573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDCA00D14
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D591188401E
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C11FC118;
	Fri,  3 Jan 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meOuPxmX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064C1FC100;
	Fri,  3 Jan 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926275; cv=none; b=j65ssdqmZYDWnKqmM5hAVUVZkrTgWsy6VqEghmmzzZzCHPEW/MyL2kDBvIppPYzR/Br7sZiKBejQE8Vf90od09CYZhYYahCHvxYIja0Yvx8cv+Am506FsDj/S5zKt5oEgS4ZVSmdTYvhjcdFl874A0MQ02su2eRC5qQvMK0pz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926275; c=relaxed/simple;
	bh=pRVkikpR9atkH7Z9yyBq4g6p9KSycIkZ3xWUYDx7kKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ojp5+Gm+KObHHYR9JHDDQXL/cPA9hqFjsvHrJrHhOElB1GLxfYTiOJ/HNqd1ZYIckV3Q3gkDxuRJEeOQLdufhvyNac859Cks+/dDGtBaUj1f2Ixly27bNrWBsjLPFUTxX70ZhPlALhzJUOiSz1H9fAeQwu/12LjX/wM5o2RFyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meOuPxmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02697C4CED6;
	Fri,  3 Jan 2025 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926275;
	bh=pRVkikpR9atkH7Z9yyBq4g6p9KSycIkZ3xWUYDx7kKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=meOuPxmX/Ck1O9Y0poyu1vIfbHYu57927aYMHr4c+lFo4un3h0FURP6ahYknhqadI
	 Ou3VE5lCVqinSr+c8Ca+iIDQm550srFu7W26FsUMWJpjdA4+n8mRM7dLEHg8xSPaqP
	 8uEmFVTOnt42FDy6XzozpeQulJLK6F/LapjtG2jjw8z40p+fYAO1Uk1d0RJiOIMAsw
	 HeBZrvMlEAV40/iwAhBNNadnacwoWmNvPaRMbqDe+q0Bwsqm2/Cf4pkwB2e5Vu/oPS
	 Rz/a4yLi/ZewxdQd392AAm4dRgoMDQuSPqZW2Fis9fDjNtXPetd2B+BiXacAoGTxrz
	 HeQV+3vysqs6g==
Date: Fri, 3 Jan 2025 11:44:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
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
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
Subject: Re: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Message-ID: <20250103174432.GA4182129@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228184949.31582-7-yury.norov@gmail.com>

On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> cpumask_next_wrap_old() has two additional parameters, comparing to it's
> analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> historical.

s/it's/its/

Personally I think cscope/tags/git grep make "find_next_bit_wrap()"
enough even without mentioning "linux/find.h".

> + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> + *			   @n and wrapping around, if needed
> + * @n: the cpu prior to the place to search (i.e. return will be > @n)

Is the return really > @n if it wraps?

