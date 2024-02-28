Return-Path: <linux-hyperv+bounces-1598-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F4186A87A
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Feb 2024 07:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D8E1F25D96
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Feb 2024 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F62374C;
	Wed, 28 Feb 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A2pGNn3+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4672522638;
	Wed, 28 Feb 2024 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102621; cv=none; b=mK3h5T+D0u94MRB176g3g6VLAYm6fEEILE3EVdbcbpw7wH4t+T0eLDMND7sDGqSVFT9B69VbbT5imCMtWlu2OsDscnX10QOsrsgGpb+LWWYW8+RA3oQRhPKWgDlVkEJ5uNCdC4I1wSY5gYB/OgSyLeXoiJ2/eHFB4JMrFhMlURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102621; c=relaxed/simple;
	bh=Kq1Ae7/0Yd/vncOJ774Xuv/NHFHZQvwgiW47Ijr+Mo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf2VMHxCzh4Xw2LK9T8dCQk0pHyuA688VnpiVNSlsJuw8Ww9qj3+1eMFOUL/pUnTkLMewF0IdCryy0otj3CvgKLMbYErGvcQZXg02UOUV9jA85RpTwN0MEdtHJiu5/dahp1+JPNJsjEvHrtFBgltp17wSwuol95GyX3vMTzinfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A2pGNn3+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id B4FBD20B74C0; Tue, 27 Feb 2024 22:43:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4FBD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709102619;
	bh=tmubg1SbFwAIrQWmTiq/y8+jK/3FCZfPgB+eI0chJE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2pGNn3+Uc5rAZp8xS/+vBI7P7XxUqhLENU2bkV9fWXFhJxys4E3RY34Vfrr/zMdz
	 q0ANyCINzUZo1/Okbjrj9WPv9RGYhySvtSrx3Y9wTpOmOw1rVK8F30fucPFU+nxcE0
	 GA8EuUltFhMU3CyeRZWyz+7krjwNPXzwfwg+P/Es=
Date: Tue, 27 Feb 2024 22:43:39 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Olaf Hering <olaf@aepfle.de>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection
 profile
Message-ID: <20240228064339.GA10916@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
 <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
 <CAK3XEhMzLvxTbP+sFjD7btfdjw5uxyAccdT09d4hcw5hkCKXHQ@mail.gmail.com>
 <CAK3XEhOn+k7U88sMF2tXGSyhYvAL9u17sw6qvomL=oYESRMQkw@mail.gmail.com>
 <20240105054153.GA18258@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAK3XEhNRuFq=x22q011uthNdrzWzTeFzzEoNX0ZjWfcivfhyCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3XEhNRuFq=x22q011uthNdrzWzTeFzzEoNX0ZjWfcivfhyCw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Ani,

This patch should be out for review by mid next week.

Thanks and Regards,
Shradha.
On Sat, Feb 24, 2024 at 09:48:17PM +0530, Ani Sinha wrote:
> On Fri, 5 Jan, 2024, 11:12 am Shradha Gupta, <
> shradhagupta@linux.microsoft.com> wrote:
> 
> > On Sat, Dec 23, 2023 at 01:35:26PM +0530, Ani Sinha wrote:
> > > On Sat, Dec 23, 2023 at 12:43???PM Ani Sinha <anisinha@redhat.com>
> > wrote:
> > > >
> > > > On Fri, Oct 13, 2023 at 3:06???PM Ani Sinha <anisinha@redhat.com>
> > wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On 09-Oct-2023, at 4:08 PM, Shradha Gupta <
> > shradhagupta@linux.microsoft.com> wrote:
> > > > > >
> > > > > > Ifcfg config file support in NetworkManger is deprecated. This
> > patch
> > > > > > provides support for the new keyfile config format for connection
> > > > > > profiles in NetworkManager. The patch modifies the hv_kvp_daemon
> > code
> > > > > > to generate the new network configuration in keyfile
> > > > > > format(.ini-style format) along with a ifcfg format configuration.
> > > > > > The ifcfg format configuration is also retained to support easy
> > > > > > backward compatibility for distro vendors. These configurations are
> > > > > > stored in temp files which are further translated using the
> > > > > > hv_set_ifconfig.sh script. This script is implemented by individual
> > > > > > distros based on the network management commands supported.
> > > > > > For example, RHEL's implementation could be found here:
> > > > > >
> > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
> > > > > > Debian's implementation could be found here:
> > > > > >
> > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig
> > > > > >
> > > > > > The next part of this support is to let the Distro vendors consume
> > > > > > these modified implementations to the new configuration format.
> > > > > >
> > > > > > Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
> > > > >
> > > > > Was this patch tested with ipv6? We are seeing a mix of ipv6 and
> > ipv4 addresses in ipv6 section:
> > > >
> > > > There is also another issue which is kind of a design problem that
> > > > existed from the get go but now is exposed since keyfile support was
> > > > added.
> > > > Imagine we configure both ipv6 and ipv4 and some interfaces have ipv4
> > > > addresses and some have ipv6.
> > > > getifaddres() call in kvp_get_ip_info() will return a linked list per
> > > > interface. The code sets ip_buffer->addr_family based on the address
> > > > family of the address set for the interface. We use this to determine
> > > > which section in the keyfile to use, ipv6 or ipv4. However, once we
> > > > make this decision, we are locked in. The issue here is that
> > > > kvp_process_ip_address() that extracts the IP addresses concatenate
> > > > the addresses in a single buffer separating the IPs with ";". Thus
> > > > across interfaces, the buffer can contain both ipv4 and ipv6 addresses
> > > > separated by ";" if both v4 and v6 are configured. This is problematic
> > > > as the addr_family can be either ipv4 or ipv6 but not both.
> > > > Essentially, we can have a situation that for a single addr_family in
> > > > hv_kvp_ipaddr_value struct, the ip_addr member can be a buffer
> > > > containing both ipv6 and ipv4 addresses. Notice that
> > > > process_ip_string() handles this by iterating through the string and
> > > > for each ip extracted, it individually determines if the IP is a v6 or
> > > > a v4 and adds "IPV6ADDR" or "IPADDR" to the ifcfg file accordingly.
> > > > process_ip_string_nm() does not do that and solely makes the
> > > > determination based on is_ipv6 values which is based on a single
> > > > addr_family value above. Thus, it cannot possibly know whether the
> > > > specific IP address extracted from the string is a v4 or v6. Unlike
> > > > for ifcfg files, fir nm keyfiles, we need to add v4 and v6 addresses
> > > > in specific sections and we cannot mix the two. So we need to make two
> > > > passes. One for v4 and one for v6 and then add IPs in the respective
> > > > sections.
> > > >
> > > > This issue needs to be looked into and unless it's resolved, we cannot
> > > > support both ipv4 and ipv6 addresses at the same time.
> > >
> > > In the short term, we should probably do this to avoid the mismatch :
> > >
> > > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > > index 318e2dad27e0..b77c8edfe663 100644
> > > --- a/tools/hv/hv_kvp_daemon.c
> > > +++ b/tools/hv/hv_kvp_daemon.c
> > > @@ -1216,6 +1216,9 @@ static int process_ip_string_nm(FILE *f, char
> > > *ip_string, char *subnet,
> > >                                                        subnet_addr,
> > >                                                        (MAX_IP_ADDR_SIZE
> > *
> > >                                                         2))) {
> > > +               if (is_ipv6 == is_ipv4((char*) addr))
> > > +                   continue;
> > > +
> > >                 if (!is_ipv6)
> > >                         plen = kvp_subnet_to_plen((char *)subnet_addr);
> > >                 else
> > >
> > > But this is really a short term hack.
> > Thanks for bringing this up Ani. I will try to fix this in a new patch
> > (would get the new testcases added in our suite as well)
> >
> 
> Has there been any progress on this front?
> 
> 
> >

