Return-Path: <linux-hyperv+bounces-7582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61201C5C25C
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 10:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D664352D63
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A123741;
	Fri, 14 Nov 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=profitora.pl header.i=@profitora.pl header.b="FWaE5fbh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.profitora.pl (mail.profitora.pl [51.77.245.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1F2C326F
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.245.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111003; cv=none; b=NbL1kTBhCxGyN3hVuZ3MhjkB3Zt5xIWSinQp0M5PEXpu+vn6e05Ni3luDDXGC5otIJrIayg44zEeBpNJhIned+l4txM1ScnK1R95FG5cOisBK5I+Ar+vgQY9gRAdAvi1mhqn8heXJm6ybplWY+5SQ9mXsL7SEhxnzg4KmSs8Hi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111003; c=relaxed/simple;
	bh=o86VRlmMq0vXKlTcHzYrlK4QfiiIlkn2xN6ePAtHamk=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=nOIBizWrCuxkiSM3C4+isfsh3TUEwF5Q5ZlZzvzQGlBJ+Y7vUi7xYlDzDjBfVDHnQCXZZeBTyJfuO387xipSrWHdJs47JBLqHxzSV6h3Bc5/G/oGFNkl7aJf/TC6eGVCLYsagkLZ2YYx5sY4PFtNFvVNOWND7ac0urSW9QFsP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=profitora.pl; spf=pass smtp.mailfrom=profitora.pl; dkim=pass (2048-bit key) header.d=profitora.pl header.i=@profitora.pl header.b=FWaE5fbh; arc=none smtp.client-ip=51.77.245.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=profitora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=profitora.pl
Received: by mail.profitora.pl (Postfix, from userid 1002)
	id 64D6225CFF; Fri, 14 Nov 2025 09:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=profitora.pl; s=mail;
	t=1763110601; bh=o86VRlmMq0vXKlTcHzYrlK4QfiiIlkn2xN6ePAtHamk=;
	h=Date:From:To:Subject:From;
	b=FWaE5fbhL2NmK0O0P0GUrkAFnxw94jFpY8Xa/eUshtbTvvaV9m1DF4anL+1bDplf3
	 pC79wCIuMaVHGGIpdlY8JvkHJq/Npd2tdqhSP80kWJE6ke/q4cPXLjRGqZlDnu2i8l
	 QjsoV9uKXtPQ0HkCt6i1LHzoizYlHtAAy+ZJZmr4pX+ceVObiQAw4ATeYpoRUqO3IF
	 +UH6ct63So8AdniFE38rxj0aS97K+k8om+5RRfvfAbaxKPgPccVq6AIOHAx/QfxQvT
	 8RR0ZtrExpKq4u9dj+qQH2SpAvzBjtnCBfP6pzoNiG8+xi356VzH6h7Uvht8Vf2lrZ
	 enAlq90s/UOJw==
Received: by mail.profitora.pl for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 08:56:00 GMT
Message-ID: <20251114084500-0.1.lv.1n3px.0.o6kzc8dlp0@profitora.pl>
Date: Fri, 14 Nov 2025 08:56:00 GMT
From: "Bartosz Witkowski" <bartosz.witkowski@profitora.pl>
To: <linux-hyperv@vger.kernel.org>
Subject: Instalacja pv
X-Mailer: mail.profitora.pl
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

wiem, =C5=BCe fotowoltaika to dla Pa=C5=84stwa dobrze znany temat, ale po=
zwol=C4=99 sobie jedynie zwr=C3=B3ci=C4=87 uwag=C4=99 na najnowsze dane d=
otycz=C4=85ce op=C5=82acalno=C5=9Bci tej inwestycji.

System o mocy 5 kW pozwala obecnie zaoszcz=C4=99dzi=C4=87 nawet 5000 z=C5=
=82 rocznie, a dobrze dobrana instalacja pokrywa do 80% rocznego zapotrze=
bowania na energi=C4=99, zmniejszaj=C4=85c rachunki.=20

Nowoczesne panele s=C4=85 coraz wydajniejsze i trwalsze, a rosn=C4=85ce c=
eny pr=C4=85du tylko wzmacniaj=C4=85 rentowno=C5=9B=C4=87 projektu.

Czy chcieliby Pa=C5=84stwo sprawdzi=C4=87, jak zoptymalizowa=C4=87 istnie=
j=C4=85c=C4=85 lub planowan=C4=85 instalacj=C4=99?


Pozdrawiam
Bartosz Witkowski

