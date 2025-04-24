Return-Path: <linux-hyperv+bounces-5088-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15545A9A849
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 11:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF85446283
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B75222561;
	Thu, 24 Apr 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNiXQcRY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1882222C8;
	Thu, 24 Apr 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487113; cv=none; b=CC5m3B+ntqJoW8gU5uxd/eEiha3dxCoCASuL9/I8ArQZCDmmZFST90TZ8IbyCHachnyAiZPoyNZyAPakZmEwPKVX8dtImJuJ+GTcoIQK7ObKhD4RpQlJFyY2EFXmO8cpG46a15ff6qYK7wpZitblwzwGyxzmYo7pnKYOLQDDGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487113; c=relaxed/simple;
	bh=qCufCvxDi1+MqzijsET6fq/x9n2E81MIiZiD/rfpgRk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VoWE+LdQ9CjBYr22ySwzNQ8VL7k8NTTTmhZ5pYGNibKQls8qdEmUrMTCfmDDW4xKca476+SGae+c0+cOr15VRBmFZlG0IEXdQpPkfXdJb+LWJrvYCJBiqDaPsJQKJDy+/3VbgYXTbLDMJl/0bgb9aoD4DUsSBYivbIOVCpo6p0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNiXQcRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F085C4CEE3;
	Thu, 24 Apr 2025 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745487112;
	bh=qCufCvxDi1+MqzijsET6fq/x9n2E81MIiZiD/rfpgRk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tNiXQcRYE3abNCB8tT3I2WPZjSHSXQis/7GPR5re2Tl55/j7D1jxysGcXfrdRWRsb
	 vEtgABQcd7bgXpaFmStU5vvaVgPFiRaf8IY1YRGQJF4A9VtNSpOnAlPhPmnF9hdq+x
	 yUD2xatpyMO6hu1ehVIWDnecG94LYsywNvd13DhC5relKlk+DwD73iyotc+5j2kEd+
	 Qpc3vHX3ivVHpUg60TXqlXH87n50QLmg8CuDpSf0Sm1UcXWKWqTFhbvKHXv83ezEws
	 hhlgelXlovG+5lHW2bnmnLzbf+ztABNSu17futNGiD7oeQZqWIujutByW+m193AkA4
	 5DcO1DS2aKKXA==
Date: Thu, 24 Apr 2025 11:31:49 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Terry Junge <linuxhid@cosmicgizmosystems.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Nikita Zhandarovich <n.zhandarovich@fintech.ru>, 
    Alan Stern <stern@rowland.harvard.edu>, Kees Cook <kees@kernel.org>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-input@vger.kernel.org, 
    linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
    syzkaller-bugs@googlegroups.com, lvc-project@linuxtesting.org, 
    syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: usbhid: Eliminate recurrent out-of-bounds bug
 in usbhid_parse()
In-Reply-To: <20250312222333.2296363-1-linuxhid@cosmicgizmosystems.com>
Message-ID: <727o0521-q24p-s0qq-66n0-sn436rpqqr1p@xreary.bet>
References: <20250307045449.745634-1-linuxhid@cosmicgizmosystems.com> <20250312222333.2296363-1-linuxhid@cosmicgizmosystems.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Mar 2025, Terry Junge wrote:

> Update struct hid_descriptor to better reflect the mandatory and
> optional parts of the HID Descriptor as per USB HID 1.11 specification.
> Note: the kernel currently does not parse any optional HID class
> descriptors, only the mandatory report descriptor.
> 
> Update all references to member element desc[0] to rpt_desc.
> 
> Add test to verify bLength and bNumDescriptors values are valid.
> 
> Replace the for loop with direct access to the mandatory HID class
> descriptor member for the report descriptor. This eliminates the
> possibility of getting an out-of-bounds fault.
> 
> Add a warning message if the HID descriptor contains any unsupported
> optional HID class descriptors.
> 
> Reported-by: syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
> Fixes: f043bfc98c19 ("HID: usbhid: fix out-of-bounds bug")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


