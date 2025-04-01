Return-Path: <linux-hyperv+bounces-4758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1DA77339
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Apr 2025 06:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123083ADDF3
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Apr 2025 04:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E4187550;
	Tue,  1 Apr 2025 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Na0zForS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F54AEE0;
	Tue,  1 Apr 2025 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743480371; cv=none; b=PP03lJU6Tdt/5b/JVLrpHfvy6Snh6HvkxlAidSYUoL6ffGmfYeggCGHzNvVIqfhrkOWhRKhaFE3KLplyyCcd44ozT2aV1mPBdzEd2iHfGRhBlsdWA25iYMc1RzUjSWhgLsaalp4wZJ0ghmV462mf/uUvGQZltJvZX9KbxPcWpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743480371; c=relaxed/simple;
	bh=AOFkwiMxE25CkrPfbOCrU6wMEe3EHjZDX79rsju8ecA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so0x4+T5JH7knf7vmYreOF7kz9vbCkUD/AcGmLEwHjsEvfPsep6kN//QzJe+My+nxBHMz7ZxEYpkZGYLJmScq2I+hutu2SsYkvb0QQQ4EwzOvx9Cj4wV8pYnsz80ZKxxEkNsRed17m3kET2lnZbHVOSHB30FGJS2N7GrIJfSiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Na0zForS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 6D3C6210B176; Mon, 31 Mar 2025 21:06:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D3C6210B176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743480369;
	bh=RlgM5HIy5B8eV6GCaYb9TDY0d3e1TibeLyeK88C+tl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Na0zForStOuvVEUECCGmU/TkrjsbeSt5LuZf+cRbFHXd/CwmzPfrs1GkE49x9Ertn
	 aTXCHhoEVhBI+nXSUCSDlEu1uWlylV0UBaxA82JnFzxKg2rcC2BQRQ356KAFou4XzB
	 mGWOBmltNXH9EHO3MkkvyRN0sHXPA/Z5tLfUIgYs=
Date: Mon, 31 Mar 2025 21:06:09 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <20250401040609.GA11465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1743401688-1573-1-git-send-email-shradhagupta@linux.microsoft.com>
 <BL4PR21MB462765E191592754911DB67BBFAD2@BL4PR21MB4627.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL4PR21MB462765E191592754911DB67BBFAD2@BL4PR21MB4627.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 31, 2025 at 11:20:09PM +0000, Dexuan Cui wrote:
> > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Sent: Sunday, March 30, 2025 11:15 PM
> > [...]
> > +static void convert_tm_to_string(char *tm_str, size_t tm_str_size)
> > +{
> > +	struct tm tm;
> > +	time_t t;
> > +
> > +	time(&t);
> > +	gmtime_r(&t, &tm);
> > +	strftime(tm_str, tm_str_size, "%Y-%m-%dT%H:%M:%S", &tm);
> > +}
> 
> Now the function is unnecessary since v2 uses syslog(), which already prefixes every
> message with a timestamp.

Hi Dexuan,
I have deliberately kept this timestamp in the raw message so that
if/whenever they are redirected to other file, irrespective of the
configuration of the syslog we have valid timestamp for debugging
> 
> > +static void kvp_dump_initial_pools(int pool)
> > +{
> > +	char tm_str[50];
> > +	int i;
> > +
> > +	convert_tm_to_string(tm_str, sizeof(tm_str));
> This is unnecessary now.
> 
> > +	syslog(LOG_DEBUG, "===Start dumping the contents of pool %d
> > ===\n",
> > +	       pool);
> > +
> > +	for (i = 0; i < kvp_file_info[pool].num_records; i++)
> > +		syslog(LOG_DEBUG, "[%s]: pool: %d, %d/%d key=%s
> > val=%s\n",
> > +		       tm_str, pool, i, kvp_file_info[pool].num_records,
> 
> Can you change the 'i' to 'i+1'? This makes the messages a little more natural to
> users who are not programmers :-)
sure, but I am just worried that might cause confusion when someone
tried to co-relate it with the actual kv_pool_{i} contents that start
with 0.
> 
> >  static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
> 
> Can you add a log message for KVP_OP_DELETE as well?
sure, I can add this.
> 
> Thanks,
> Dexuan

