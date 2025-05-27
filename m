Return-Path: <linux-hyperv+bounces-5674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7CDAC5A2A
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 20:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D76D3ADBF2
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68B280324;
	Tue, 27 May 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAJg/lTs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDF27C854;
	Tue, 27 May 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748371392; cv=none; b=RUWDeZlQUqpCC++jbTqovwYlNKI6HMjdEpYe0pCKLNrK2kHaAtAhT7hiVB3Pdm+6OhJosNOSB2s+0KxLp5bLC015sUOPWp2CkkKUtpxEIFHuBSS66q/2RXHyuhoOXQqXp+bQP8fBDSDabkxFDNEuOk1E9Iwntvu1dyD3ToFayu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748371392; c=relaxed/simple;
	bh=unrEi+Z8Vcid2frmRc00TpoL+pz62h5Wsf8KIjX1MAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfV8VJxNi/USAC+PEZeRUtNWnRYUO4jmF+ImjSIVibgz88fh9BeTUWJtpk9tP4U1A9FIosoix8bCpgwOY3HF8tTM5yS0BxCrsBSNSorpnIeJXBxo8oNH0BfDl7//Hbjpbr88kcZ/DmkJujm7JNlB1hv11DcmMHK5zWx/6RYhcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAJg/lTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049DC4CEEA;
	Tue, 27 May 2025 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748371392;
	bh=unrEi+Z8Vcid2frmRc00TpoL+pz62h5Wsf8KIjX1MAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAJg/lTsHFPpMmZvVmP+0XJugy76N/WOctdJIssWWs7qNHSBbzmSYg8xkWQak4g5C
	 LfZgHKgxVCZb8p0qamVGEV/1YiZTk2afQEafhl37cp97dLgGRdjvi7trKjD2XXdMuP
	 LbrGzfua9UHyhqt54e4WAAnlTo1NpBqK2l+IKnh1JQUdMKF4EbO60uwu4lUOeBUiiD
	 wKIfF3Uo87tWndWoi9LDxjhMwmt61Lxnq3QWSMVbr06JAV1rHQ9XUs10fwb75pWBr3
	 anGW5bNZOirMCaMIcgBCgcjqJ5Vcm09HGhEIuw7KuVAzISErwpzi7uyi2a2hStymIg
	 Mw76bx9c3WLMA==
Date: Tue, 27 May 2025 11:43:08 -0700
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxim Georgiev <glipus@gmail.com>, netdev@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Lei Yang <leiyang@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Philipp Hahn <phahn-oss@avm.de>, Eric Biggers <ebiggers@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2 8/8] net: core: Convert
 dev_set_mac_address_user() to use struct sockaddr_storage
Message-ID: <202505271142.EA78EAB04@keescook>
References: <20250521204310.it.500-kees@kernel.org>
 <20250521204619.2301870-8-kees@kernel.org>
 <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>

On Tue, May 27, 2025 at 09:02:28AM +0200, Paolo Abeni wrote:
> On 5/21/25 10:46 PM, Kees Cook wrote:
> > diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> > index fff13a8b48f1..616479e71466 100644
> > --- a/net/core/dev_ioctl.c
> > +++ b/net/core/dev_ioctl.c
> > @@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
> >  		return dev_set_mtu(dev, ifr->ifr_mtu);
> >  
> >  	case SIOCSIFHWADDR:
> > -		if (dev->addr_len > sizeof(struct sockaddr))
> > +		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
> >  			return -EINVAL;
> > -		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
> > +		return dev_set_mac_address_user(dev,
> > +						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
> > +						NULL);
> 
> Side note for a possible follow-up: the above pattern is repeated a
> couple of times: IMHO consolidating it into an helper would be nice.

Yeah, I will look at that.

> Also such helper could/should explicitly convert ifr->ifr_hwaddr to
> sockaddr_storage and avoid the cast.

It's UAPI, so it looked verrrry painful to change.

-- 
Kees Cook

