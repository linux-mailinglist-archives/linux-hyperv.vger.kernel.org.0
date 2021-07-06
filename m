Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC363BDA62
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jul 2021 17:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhGFPnm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Jul 2021 11:43:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43014 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhGFPnm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Jul 2021 11:43:42 -0400
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8DB0120B7188;
        Tue,  6 Jul 2021 08:41:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DB0120B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625586063;
        bh=FXa3SB2i+RiGoeKML7scN56hG2dTps93chghEwKXFwI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZT1tH4M9oi2ubnBW4DEEpT8Z1Qsiz2HpOHFXUAasnsqb8a8E4fO6QIAfnGMIXbwuu
         Me7tmy0hrMR1sOtDy2BHvEi5ilk5QRL1Huv+bVMc/ze3DkbfUSLb563At1Dy+pKHLf
         3o7CZfb29iboGM9nvDyllpxt12otjAENKhGrp6x0=
Subject: Re: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        vkuznets@redhat.com, ligrassi@microsoft.com, kys@microsoft.com
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
 <20210627120004.u4pn3stgcny2zl4i@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <c88d08ee-b559-f1a3-b53c-d740f60273e3@linux.microsoft.com>
Date:   Tue, 6 Jul 2021 08:41:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627120004.u4pn3stgcny2zl4i@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 6/27/2021 5:00 AM, Wei Liu wrote:
> On Fri, May 28, 2021 at 03:43:23PM -0700, Nuno Das Neves wrote:
> [...]
>> +
>> +static int
>> +__init mshv_init(void)
>> +{
>> +	int ret;
> 
> Please check if Linux is running on Microsoft Hypervisor here. If not,
> this module should not be loaded.
> 
> Something like:
> 
>        if (!hv_is_hyperv_initialized())
>                return -ENODEV;

Good point - will do.

> 
> Wei.
> 
