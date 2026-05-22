Return-Path: <linux-hyperv+bounces-11157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NcTyAXs7EGrUVAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11157-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 13:18:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE85B2DBB
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922923037411
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201D3CEBBD;
	Fri, 22 May 2026 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kByxYnLA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B03D4130;
	Fri, 22 May 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448277; cv=none; b=rSvo80PaZiQEeC5Vmv2NX+xwrkgv51QOWwlUNRU0kqr0JACd7u7W3YExFIXiSIBaYi+PtDIEe4cb407oh4MygQiCxlCjo69KvyqCp02dtUNzkeyfWGO5kc5lzT+KaqOVBzaP2fDyraNetlp5zQfDZongObWU/KWPtIQOvgnII7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448277; c=relaxed/simple;
	bh=sJ9O8YTbPakJduu12s82u8FDnlS6fHPrETn1Mha5KM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCPccLCzsr1fOKp3mlBpi4/BcFI3gn5jWAzPBHoONuEOOMM8Q/69nmGFa7B1ps1FEj6z9UK1ODMCEo5yT8/9wwzzCunkCcqWHs1c52VEac1Y7Aa5Lopah5VtOsAM0U4ezq2apsP+6/d1ZxGrucoT5P0uvmPloetm3jR2s+WEGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kByxYnLA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E27B1F000E9;
	Fri, 22 May 2026 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779448275;
	bh=66Ly+hs4R/27WKxigMfnhQ6cNsddC+cSlfhgKT3lCpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kByxYnLAQfNZYcLuV0MwtqkfOmkCcs/8kmlYVz8QfyQuy228VdX5TGZDvZMAhwBUd
	 D9lHk13DAIGY9RN8eJV7YbmQzhZ1dykxODMEIsO0zauDRqYcyjHAZrR1cKjax4uOQ5
	 Mdh0Rl7J8WnvKa1YfGdsH2zLNC8TjjSSbb/ZelK4=
Date: Fri, 22 May 2026 13:11:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, linux@armlinux.org.uk, nipun.gupta@amd.com,
	nikhil.agarwal@amd.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	andersson@kernel.org, mathieu.poirier@linaro.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] treewide: Convert buses to use generic
 driver_override
Message-ID: <2026052210-surplus-earthling-c205@gregkh>
References: <20260505133935.3772495-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505133935.3772495-1-dakr@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11157-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,gitlab.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8BCE85B2DBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 05, 2026 at 03:37:20PM +0200, Danilo Krummrich wrote:
> This is the follow-up of the driver_override generalization in [1], converting
> the remaining 4 busses and removing the now-unused driver_set_override() helper.
> 
> All of them are prone to the potential UAF described in [2], caused by accessing
> the driver_override field from their corresponding match() callback.
> 
> In order to address this, the generalized driver_override field in struct device
> is protected with a spinlock. The driver-core provides accessors, such as
> device_match_driver_override(), device_has_driver_override() and
> device_set_driver_override(), which all ensure proper locking internally.
> 
> Additionally, the driver-core provides a driver_override flag in struct
> bus_type, which, once enabled, automatically registers generic sysfs callbacks,
> allowing userspace to modify the driver_override field.
> 
> This series is based on v7.1-rc1 with no additional dependencies, hence those
> patches can be picked up by subsystems individually.
> 
> [1] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.org/
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=220789
> [3] https://gitlab.com/driverctl/driverctl/-/blob/0.121/driverctl?ref_type=tags#L99


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

