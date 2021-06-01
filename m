Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE95397ACF
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jun 2021 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhFATr0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Jun 2021 15:47:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55934 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATr0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Jun 2021 15:47:26 -0400
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id E8F5D20B7178;
        Tue,  1 Jun 2021 12:45:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8F5D20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622576744;
        bh=b2RbQ9AC3QekddS3W4agCzij1UKySYCbh6vo4knr50Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LirxQxYn+m34RaAkGCwVuf7axZVZ64jQBkA2XKiJMn0HH0AgJkNl7gWK+mUzpx9vm
         +tRZMZrEL/sxkQBrdAaU/GIBZxGK4B8obuEfGlH9ZJRJSZ5q7ChmW7mKPeg9W1C2XH
         B/L/aGLRxe9RTlpZRuEoEK7Q7YDVx3zYpK1vBSqE=
Subject: Re: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
To:     Randy Dunlap <rdunlap@infradead.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
 <e161e8cc-4d08-8bfd-ab1e-363ed5a39503@infradead.org>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <948ea565-673d-3b08-9fe3-c69ca6eee727@linux.microsoft.com>
Date:   Tue, 1 Jun 2021 12:45:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e161e8cc-4d08-8bfd-ab1e-363ed5a39503@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 5/28/2021 5:01 PM, Randy Dunlap wrote:
> On 5/28/21 3:43 PM, Nuno Das Neves wrote:
>> Introduce a barebones module file for the mshv API.
>> Introduce CONFIG_HYPERV_ROOT_API for controlling compilation of mshv.
>>
>> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
> 
> Hi,
> 
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 66c794d92391..d618b1fab2bb 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -27,4 +27,22 @@ config HYPERV_BALLOON
>>  	help
>>  	  Select this option to enable Hyper-V Balloon driver.
>>  
>> +config HYPERV_ROOT_API
>> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
>> +	depends on HYPERV
>> +	help
>> +	  Provides access to interfaces for managing guest virtual machines
>> +	  running under the Microsoft Hypervisor.
>> +
>> +	  These interfaces will only work when Linux is running as root
>> +	  partition on the Microsoft Hypervisor.
>> +
>> +	  The interfaces are provided via a device named /dev/mshv.
>> +
>> +	  To compile this as a module, choose M here.
>> +          The module is named mshv.
> 
> ^^^^^^^^^^^^^
> 
> Please follow coding-style for Kconfig files:
> 
> (from Documentation/process/coding-style.rst, section 10):
> 
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
> 

Oops, thanks for catching that!

>> +
>> +	  If unsure, say N.
>> +
>> +
>>  endmenu
> 
> thanks.
> 
