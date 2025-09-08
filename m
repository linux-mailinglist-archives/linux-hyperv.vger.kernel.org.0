Return-Path: <linux-hyperv+bounces-6775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430CB4837E
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 07:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F50F1736BD
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 05:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE1917A2EA;
	Mon,  8 Sep 2025 05:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEv+XPzy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984236B;
	Mon,  8 Sep 2025 05:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307709; cv=none; b=O8SMdfPvkaBDg2pgOFDkb4oTFLVa8musIJbMgXjs0Uj88D45yFgtfX4ROsj1fo92jHuCXpkXne2csDDhop2ci+BNGtRWyudppuPXOCRxMtRtJQpXdR7VeK2IHxp1YSo8x4xhKfsnjnz1BqCX+U6E/TMUMJ09jTaX2BXSbUZugtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307709; c=relaxed/simple;
	bh=dS2wsjUpjJr8agKHSksEWK4Gd3UlvHrI9Y9ZHjDPXds=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YfTixApLiijvn7FJ6yUVDuUbzSFDVu0kQ2DxJFFp05eNkpZD+hHbUTKlTR7p7GRI7krkyWy+X5mlXQCf6czzVsRZSbG8ffq6H4aRAzAjxElccv1URllMVM4D/w+7keBcTyhYdAEK4pvgPBnZS+1+3ZfytBBq0L5y2+3fqam6Aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEv+XPzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B0EC4CEF5;
	Mon,  8 Sep 2025 05:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757307709;
	bh=dS2wsjUpjJr8agKHSksEWK4Gd3UlvHrI9Y9ZHjDPXds=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mEv+XPzyGqnS0ywfo+WJZxC/Z5pCqJ3KNB/mIrLeJ15ifEsUJ3VaFDCy6ZnWg3ogQ
	 9bITBYahnM9M6VJdM20BpS7w28tNESmcSmmOVimABQSl5wjBI3skSNpcnRhc0cCd78
	 dP+oOG3yHyusgwDVsOpm1M/fqK+AcXz9c+vTUYQ6oIOYmw55bo66pV6su5cz0V7IEV
	 jVGm3Cfv7ySDCN85qYUFRIV5q6S9kd5wPLdJlF4RJbc0cVAw7raZ4AE35SDbsDvaJS
	 /29lnMJrMYuxUpkaVPlvPMAyyCd+fQ38VIZ+B6FF6+FOM0Vu0LoJP17jpIT164nM8w
	 r+BFk23l2JfRQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: "K . Y . Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
In-Reply-To: <20250813055350.1670245-1-namcao@linutronix.de>
References: <20250813055350.1670245-1-namcao@linutronix.de>
Subject: Re: [PATCH] PCI: hv: Remove unused parameter of hv_msi_free()
Message-Id: <175730770554.7580.1535538144092861804.b4-ty@kernel.org>
Date: Mon, 08 Sep 2025 10:31:45 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 13 Aug 2025 07:53:50 +0200, Nam Cao wrote:
> The 'info' parameter of hv_msi_free() is unused. Delete it.
> 
> 

Applied, thanks!

[1/1] PCI: hv: Remove unused parameter of hv_msi_free()
      commit: ce47f81925ed73f9d27b1a01f07afdb031949c68

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


