Return-Path: <linux-hyperv+bounces-5593-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DAFABEA2D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 05:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE701B659A8
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 03:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5C22B8A7;
	Wed, 21 May 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSp6blwN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA88482EB;
	Wed, 21 May 2025 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796973; cv=none; b=l41ADlnXpg4AtWzv4nwt/ZNSKoqpGJF4pLkBXepoNxlm7xqKlUn9epst+E3WsRtAcGEWKfiuKavO4n2k1kOREp8QL9A3fcV7k+FBYvqeyW8xpls9UPXcqyBMFTVthgHHudnS50ij/t6kP4jWlDDzuoOrGbimveoGzJBhvFvWsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796973; c=relaxed/simple;
	bh=MzDBPdt+NOJuZUnRvn7D0hSDT7QUWWhCWPHDebkE6yM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAisWHnazjC4fccz/Q9IzefTdEDsjhl2terNBbwrmBT+nTtCBj4bn97P0hzVYhoCqrVepZxAPJT2p25CTIFdAPGiLYG6agKVIxQR+8LRn0cK/dg5y/K5pjH7SQONN3bGvSg1fuICpfSIm3lB2cA8uWU/fMj5+k/gBKiAvNfppDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSp6blwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDD2C4CEE9;
	Wed, 21 May 2025 03:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747796972;
	bh=MzDBPdt+NOJuZUnRvn7D0hSDT7QUWWhCWPHDebkE6yM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSp6blwNJ2IEI0zxxm4wg6b/R5V8dLrbx2SaV54oQnibx34rjyiLBnPqyvVGGo0/v
	 4a9VJ/1ZJBPKALlSZQ09HMCGg86MWHTm0TcJhRTmy98Z4Vxv+BmPKMgT4WrgEm9JsJ
	 O6+PissEq05oWwGcnqWiKCdGml+a0ZoNrUOOEjgxvqK/PQVItypF0uX3l8u7xeUr7k
	 QUy3Hk85t+zwEd35Q+iVL+qq1cs2To0at1zcaI2vpClgypEuiaeUhLs2bGeO/A2sta
	 RJOsU0YzaDSVVumW/jDtX8coTK0AAjbM5OTTeUHmk2EaH21WC5ZLwhCMSKK+ahHamw
	 AxMbSY2OTIELA==
Date: Tue, 20 May 2025 20:09:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alex.aring@gmail.com, andrew+netdev@lunn.ch,
 ardb@kernel.org, christophe.leroy@csgroup.eu, cratiu@nvidia.com,
 d.bogdanov@yadro.com, davem@davemloft.net, decui@microsoft.com,
 dianders@chromium.org, ebiggers@google.com, edumazet@google.com,
 fercerpav@gmail.com, gmazyland@gmail.com, grundler@chromium.org,
 haiyangz@microsoft.com, hayeswang@realtek.com, hch@lst.de,
 horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, jv@jvosburgh.net,
 kch@nvidia.com, kys@microsoft.com, leiyang@redhat.com,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux@treblig.org, martin.petersen@oracle.com,
 mgurtovoy@nvidia.com, michael.christie@oracle.com,
 mingzhe.zou@easystack.cn, miquel.raynal@bootlin.com, mlombard@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com, phahn-oss@avm.de,
 sagi@grimberg.me, sam@mendozajonas.com, sdf@fomichev.me,
 shaw.leon@gmail.com, stefan@datenfreihafen.org,
 target-devel@vger.kernel.org, viro@zeniv.linux.org.uk, wei.liu@kernel.org
Subject: Re: [PATCH 0/7] net: Convert dev_set_mac_address() to struct
 sockaddr_storage
Message-ID: <20250520200929.1b9ae5ec@kernel.org>
In-Reply-To: <202505201741.AFA146E7F6@keescook>
References: <20250520222452.work.063-kees@kernel.org>
	<20250521001931.7761-1-kuniyu@amazon.com>
	<202505201741.AFA146E7F6@keescook>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 17:42:32 -0700 Kees Cook wrote:
> Ah yes, I can include that in the next version if you want? I was trying
> to find a stopping point since everything kind of touches everything ...

Looks like the build considers -Wincompatible-pointer-types to always
imply -Werror or some such? We explicitly disable CONFIG_WERROR in our
CI, but we still get:

drivers/net/macvlan.c:1302:34: error: incompatible pointer types passing 'struct sockaddr *' to parameter of type 'struct __kernel_sockaddr_storage *' [-Werror,-Wincompatible-pointer-types]
 1302 |                 dev_set_mac_address(port->dev, &sa, NULL);
      |                                                ^~~

on this series :(
-- 
pw-bot: cr

