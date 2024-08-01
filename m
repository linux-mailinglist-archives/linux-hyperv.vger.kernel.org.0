Return-Path: <linux-hyperv+bounces-2640-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97446944203
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 05:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CFE1C2241E
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0953513D24D;
	Thu,  1 Aug 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D0o4hWWE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F291EB4A6;
	Thu,  1 Aug 2024 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484228; cv=none; b=sar1BdtseJboSIQTOUyK9LLi9RE/lwLVDJy7Eky7Xc+IaQ957P3EKmW4DfjSJDS4C14Nitv7I2ay9kZOiX7y2HatAdg2//P8HOgkACquGM1tgL0KpnNrGMspT8D3gAPYsxcTRBsYx822dNLchx4rGVHARc8omjSkkU+m8LtqubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484228; c=relaxed/simple;
	bh=HrsWFVh6vYnpFvkY4E2sOyGfiJQqrAqNdgRIIPss8Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVyYaRIJVDX+WBp/9xDapB+kr/3J7z3RDv1K818oB5MeZRDBPBALq/WeBoCft3cD0HMTS7xz+mM8Qi4uyxaWgS7NBsgReeSzAndb2v8frPen7wTVutaDfya7WekmA4iWGI7ZNgeSc9WKTzVc4IZSfWqkpDCEn3kEAI/pYKhMoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D0o4hWWE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4AC6520B7165; Wed, 31 Jul 2024 20:50:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AC6520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722484227;
	bh=ofmpsUy6qB0LD3wyBj59NGh/Bko3GAAYq/DGsj+elKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0o4hWWE+/ghnBxJhIbRuHv44e34flOAqM12WtvvRFuPmMZLDfkBkHbhLHVG3UOs9
	 OjO1vj2JHpXA3oqF93QrEyaJR53bu4sLt2R5jINWl3kstHcFvJDoFHzJ+RYDoQpeZW
	 Jddv+tWlS7kqroUtb6+rI4+4p0A6icu4aqE7v1SI=
Date: Wed, 31 Jul 2024 20:50:27 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240801035027.GB28115@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240731171518.3cbfc83b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731171518.3cbfc83b@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jul 31, 2024 at 05:15:18PM -0700, Jakub Kicinski wrote:
> On Tue, 30 Jul 2024 10:01:35 -0700 Shradha Gupta wrote:
> > +	err1 = mana_detach(ndev, false);
> > +	if (err1) {
> > +		netdev_err(ndev, "mana_detach failed: %d\n", err1);
> > +		return err1;
> > +	}
> > +
> > +	apc->tx_queue_size = new_tx;
> > +	apc->rx_queue_size = new_rx;
> > +	err1 = mana_attach(ndev);
> > +	if (!err1)
> > +		return 0;
> > +
> > +	netdev_err(ndev, "mana_attach failed: %d\n", err1);
> > +
> > +	/* Try rolling back to the older values */
> > +	apc->tx_queue_size = old_tx;
> > +	apc->rx_queue_size = old_rx;
> > +	err2 = mana_attach(ndev);
> 
> If system is under memory pressure there's no guarantee you'll get 
> the memory back, even if you revert to the old counts.
> We strongly recommend you refactor the code to hold onto the old memory
> until you're sure new config works.
Okay, that makes sense. Let me try to make that change

Thanks,
Shradha.
> -- 
> pw-bot: cr

