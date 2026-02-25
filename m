Return-Path: <linux-hyperv+bounces-8987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOPtFl0zn2lXZQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8987-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 18:37:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF219BA60
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 18:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA84A309A2CA
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1043E958B;
	Wed, 25 Feb 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IOgby70S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D723D905D;
	Wed, 25 Feb 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041011; cv=none; b=oq5TbiMH4KcWhQtcf3HzqYQ3me4yUVUzEI096T/1MMKDcgHu2nA5wM06WjjAcjK3AQ1YL1R1ZTq6VGq7E2CqSBB9JXeDgj055vTkc/Hx9lrCRuveUwFDviMimXL3iYYpwIawR0mvRiLPZfvXfTQn7BwHKhygmjRZMt1oXNR4+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041011; c=relaxed/simple;
	bh=rWvsnjcAOv9jIjOY8a6s9rURU50uRMxuNaOJ00vEPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlrA1EUWX9PG5Ji06BHHa4rjgVFjZXM67wH+aeFzFtKuYk31RHsWqEu4GZXMUaaMoWbhBm6hKAvRcAoXIls0DLvEKmzJftNTYUZlaM5KQ/q4sjq7+XP9ow7x7tCTNilYZnRQLC2KX1YIz5HY4/wPaBNqr8843YIWGMp1aYgVFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IOgby70S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A05D420B6F05; Wed, 25 Feb 2026 09:36:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A05D420B6F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772041004;
	bh=mHxw8afkyGAU60eBd4VVOSAY74F87eV7V2cfTZecj7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOgby70SDYLFk1Fz0Gy8dsxybR8or1VQFx/IXrMhvcwe09sTMdU/m7ICDnRg8SZMA
	 CpaiHeeMaU7kKKnHZ9fjIFh0VYOTT65RN8ugNfN9RyZhnQGnn0WSj6Rk+TRiqoK5Tj
	 S0t4l1BoBhPXoU2TvMsmQM5RtZg2vB4z8NI387tM=
Date: Wed, 25 Feb 2026 09:36:44 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Erni Sri Satya Vennela <ernis@microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org,
	dipayanroy@linux.microsoft.com, ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <aZ8zLH8AGL1h7VIp@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260223040826.750864-1-ernis@linux.microsoft.com>
 <2f11ece1-cb85-4491-89d5-c8818666ff41@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f11ece1-cb85-4491-89d5-c8818666ff41@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8987-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C6FF219BA60
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:22:58PM +0100, Paolo Abeni wrote:
> On 2/23/26 5:08 AM, Erni Sri Satya Vennela wrote:
> > @@ -861,8 +862,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> >  	tx_wr = &txq->msg_buf->reqs[msg_id];
> >  
> >  	if (req_len > tx_wr->buf_len) {
> > -		dev_err(hwc->dev, "HWC: req msg size: %d > %d\n", req_len,
> > -			tx_wr->buf_len);
> > +		dev_err(hwc->dev, "%s:%d: req msg size: %d > %d\n",
> > +			__func__, __LINE__, req_len, tx_wr->buf_len);
> 
> I fail to see any relevant information added here ...
> 
> >  		err = -EINVAL;
> >  		goto out;
> >  	}
> > @@ -878,6 +879,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> >  	req_msg->req.hwc_msg_id = msg_id;
> >  
> >  	tx_wr->msg_size = req_len;
> > +	command = req_msg->req.msg_type;
> >  
> >  	if (gc->is_pf) {
> >  		dest_vrq = hwc->pf_dest_vrq_id;
> > @@ -886,15 +888,16 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> >  
> >  	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
> >  	if (err) {
> > -		dev_err(hwc->dev, "HWC: Failed to post send WQE: %d\n", err);
> > +		dev_err(hwc->dev, "%s:%d: Failed to post send WQE: %d\n",
> > +			__func__, __LINE__, err);
> 
> ... and here. The string message should be (and apparently is) enough to
> locate the relevant code inside the tree. Please don't included
> unneeded/irrelevant changes.
> 
> Thanks,
> 
> Paolo
Thank you for the clarification, Paolo. I’ll drop these changes in the
next revision.

