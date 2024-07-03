Return-Path: <linux-hyperv+bounces-2531-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80516926482
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9028E1DD
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1CD17C205;
	Wed,  3 Jul 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QctYtcqB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE61DA319;
	Wed,  3 Jul 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019467; cv=none; b=Gh0Km+NDm3G6DG16BjoPfGj7NCIgXDq2D0JA+6UDvrONPhk4XHCm/sUm6LlDwtz8YZVy1BkFT/w9B/3UqF6lSLf5Hz1PaEICgBoPjZvLLFcrEiXipduQ26+t5AtdGD3ta88Y5cI4YgFTpHV1ziTJZbPqrBhau0uQ4mwHeu/0YG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019467; c=relaxed/simple;
	bh=3wjTP1DBKceOOiIIRZ+CtbjKJjvmYWz9hXD+GkONhlo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=G6G+R5c7NE25FndVIBgOc4IPngj3zYC1/N7yQ66Ok0Xu4hMvnLhF46g+w2n/dN9K3lpuhxo9HLB7USjZM8m+NBbUlc5oDHSFUuh5QmnsNA61hxC/TdcwRFp1peKFSyvhojOw2UvlHCj0lueJ5+jMuiDSEFocRVRxwzPAfoxPriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QctYtcqB; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720019462; x=1720624262; i=markus.elfring@web.de;
	bh=uzXyAXmbJBxGH6PQ3hVx3H9XYijhY9dW2zRghJjaRTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QctYtcqBAc9Z7SyNbdJh4kGMRJx+WhM3exw+AS54JsJAzzZq4gkRLIQRZBh/ZNdb
	 uI6gZykd6BzQo4orusmIJM/tWoGmoNRyGzcDykFjb5lQkDAGkaqEFb+uHGM8dNrAn
	 2BpIRCqL7Z3ZboCPKX+cMjk6Rrj/FmDtQFTZa38sM+nDycmzezFBDj3M4rzqdUoHG
	 Nh4Aw7GxsMH7bQA4ZL3147x892CPOhKKfxjqf/XRsH4oy16Ht/dX7qjNmTsYqNy8/
	 SORh5RcMOBzieCuU5x1d+X6LLZ+eEb02Pm6ZhTwTmDKZX0IygU7i8wz7JytqlfmHu
	 gD1IPlNrNCu6L2bEIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml46w-1rzp832BZM-00ekp4; Wed, 03
 Jul 2024 17:05:15 +0200
Message-ID: <b0fe50c3-9279-4225-aad5-2869b335fe53@web.de>
Date: Wed, 3 Jul 2024 17:05:14 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <make24@iscas.ac.cn>, linux-hyperv@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240703084221.12057-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] drivers: hv: vmbus: Add missing check for dma_set_mask
 in vmbus_device_register()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240703084221.12057-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YV8ws4IVXhh8faxR3kOPPdm6RfB/oTFu1GWuLpn3YbmM6sIdPrS
 kdcANEgP8Z3mzIkApf8ZC6F+eE8H9zgChVOZllxO5YZyDBJz7IvNo2qG7WZgbV1FEo/YUZx
 En6C+uRQWZKf47+Fgyqh7vgGCu8V+2e07I/2hNOm/g7UJknTRyTAscOnJG+1QSKMHoQuMxQ
 DH1aX6qwRzRq7oCWtKbTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:njd83SA+1ts=;J++nmAq9qfV+/27rRiJIp7+2skC
 ie7foP98eRndAw9gUKDk3/WRDjb7nlNxefeJLjVZakxQyUUScjeabFmhN8y4YEBlfvqIgbiEp
 KPWTpuOYnD1/EArT0dYcenbLcWv8sjapAypkUOzyrxC0QVk8ZbCdWezbK+K3EG8tr3FwuenQY
 14CLBPN7IlmhOa041iu7KW047zdTuG7NZalH5csWhpX91GuZkFKQhoNPVoW9waBQjaTzb4nyu
 jq0XJWtMdN/q2F+1s9EEspSgpqSK4oZHxx/aPGq9M0W8698cglHJV/fDkbyOlM1z5p3iA1Onv
 EBXX9y1GZmE5yXOeKicPzEFGDr3eDiBdMHQ6rcMmHxB8xpxGHcNAXdWdFokSE++jZpiojWzxB
 GxJGttL9jCv4COvG0PK1y9hnTdUH+mi5gGnAAgVaNwoJJv1mvSNjegmgMWksRHTaTfgdroxs4
 5b4rXt8zBwhOjCvuOHu6EM8wx+OrhviaufEY1AvOryfnqreFIGN8soeaGvfTBZJ49QILoD7/c
 T6L8/W3jHqlL5B5dmouUk+y2n23JwdfzzHX85AstyF7nmQu42rrPNpAhHhg0Tvd95MVk/Ahop
 2lpP24KXemslIloJjLqPwNKLog79crjZKVDIzkv4XvJKTT+AugA6t8DHZ6umkOV1AxCPArWpD
 qTpuH5iw5d7GEm28JtTW92Nf45Uo9nQM7gUWvuLg0JWe9rRe1edMIih5ViQ1cn/ppS9kB1hXK
 m6M+gTkoCrKx4wGSHv1lMaGB0POF22yFUY3SV5G+tTigD7oq7InFz3Bfm5v54I6/9cDoeh5Y/
 tbSYpyOkwHymqUMLqwj/jpnEGADY4DBwejG2RmYLuqliQ=

> child_device_obj->device cannot perform DMA properly if dma_set_mask()
> returns non-zero. =E2=80=A6

Can the repetition of another wording suggestion influence the software ev=
olution?
  Direct memory access can not be properly performed any more
  after a dma_set_mask() call failed.


See also:
https://elixir.bootlin.com/linux/v6.10-rc6/source/kernel/dma/mapping.c#L80=
4


=E2=80=A6
> Signed-off-by: Haoxiang Li <make24@iscas.ac.cn>

Under which circumstances will applications of the Developer's Certificate=
 of Origin
be reconsidered any more (after three different names were presented so fa=
r)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n398


Would you like to append parentheses to another function name in the summa=
ry phrase?

Regards,
Markus

