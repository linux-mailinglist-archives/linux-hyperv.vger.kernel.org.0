Return-Path: <linux-hyperv+bounces-569-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15287D211A
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Oct 2023 07:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4EEB20D79
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Oct 2023 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FF5ECD;
	Sun, 22 Oct 2023 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rk+e68Bo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9337807
	for <linux-hyperv@vger.kernel.org>; Sun, 22 Oct 2023 05:11:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E8DF;
	Sat, 21 Oct 2023 22:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=LaOSDlCHVRgG4eLBoNpIRzvo1mfgD+GAe0lAq4bGIO0=; b=rk+e68BoAezYXyP7eUCajyejDp
	4mo+UmVj3QYTd/Z+n2u+Gl2mokYB4kOBYNUe8Ht5E6kwhUUAPRjXDY8LHwFTJUIYNEawk4YvkbfHA
	wBoBdL9ev60YZ613CTXqGI6C5+tD57rOaaEuCCv/4mO/WtJkcyaYI/igK9txekZJEaPJZHpQHAYE2
	7z7su7PTxSVYvQ9nDFyWAVZTr7vTfdz6YsdWTpFVipQkaq1fBlfO6tbzS1KKRKw79nXAZsUsR/LEZ
	l8dVVvlc2j8fDFZv7dqXa0JywW8NRGOOabUb122YIYmlM3qhbgbLCaDLr7L3l5OFz0OPAXA2jItDM
	kGjOEO1A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1quQjt-004skb-0h;
	Sun, 22 Oct 2023 05:11:03 +0000
Message-ID: <a05b46db-260f-4ba9-b335-4d8cd14292e2@infradead.org>
Date: Sat, 21 Oct 2023 22:10:58 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic after booting custom kernel [hyperv message]
Content-Language: en-US
To: gmssixty gmssixty <gmssixty@gmail.com>, linux-kernel@vger.kernel.org,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <CAOx-CDU4_3j-mQcczscZ-xqq+XF7R=H62i1SoojczG8WELUMgQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOx-CDU4_3j-mQcczscZ-xqq+XF7R=H62i1SoojczG8WELUMgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[adding linux-hyperv mailing list]


On 10/21/23 22:05, gmssixty gmssixty wrote:
> I have compiled kernel-6.4.12 from source. I have put the bzImage in
> /dev/sda3/boot. Booted it. I am on virtualbox. After booting got this
> message:
> 
> Kernel panic - not syncing: XSAVE has to be disabled as it is not
> supported by this module
> 

The next line should say:

	Please add 'noxsave' to the kernel command line.

That's one (maybe temporary) solution.

> Note that, no other software has been installed in /dev/sda3. I am
> trying to boot custom linux kernel.
> 
> Why did I get this message? What should I do after this?

Do you mean to be using hyperv?
Do hyperv and virtualbox mix well?

You should post your full custom .config file.

-- 
~Randy

