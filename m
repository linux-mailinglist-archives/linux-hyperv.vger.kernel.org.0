Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FB835F77F
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhDNPUq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhDNPUp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 11:20:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48FC061574;
        Wed, 14 Apr 2021 08:20:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e2so5987297plh.8;
        Wed, 14 Apr 2021 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GjnyRXzQJs/ruevdN1h+ewCMUU5MROLW5faBjSTHYuk=;
        b=r6ySV3uMl0D+g1EvD538J47qBPrk4NpMBZ08hqgf4Erzcekb/krnaZePTtMzchncG/
         qN54me47vACgJUEe1jgJzTNhEhRKKWXbkxSYhcniON20hMC52HL82van9C0f7tNCEx0E
         ieuQb4DM/upvYoTyCmmfj6+2zCjtjf7ySM+hThuVZjs0UDhhZZKJ53HjZluPTXgS+1JI
         bM78EWw6rTQVw4/EhdX4EMXeS1ng4ucKJcohV95yRsghHehN0b7lA9J8dw7wY7dJxA1V
         NhL/SVXwqiiZNiCscBNghbJDuc1ugVWjN05e9RLZW5V4k8GnhnoJS6Y8RX+uDNXUa5dY
         1wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GjnyRXzQJs/ruevdN1h+ewCMUU5MROLW5faBjSTHYuk=;
        b=LhwuZFldjsRQF9Zc/L54mDT298sNxaGs/lLjfw1RCywfxOYh5RJdRPTjZgDO46+hyH
         bPuvgDGZx+K4ZVhPEbnqVCOA+TzACZucdGQtT5yKYuKtnUpL7Rp08sS7lD0vRpuEyIJh
         4tO/APACImWCN4m1+vUw7Ztfm155/K2e/WIMisI1/JYAxCbGfrr46fRvqsWJJI8Izh9d
         NVplLf/c4d4oTxMjwGmNupC6e/6EP39L3dBpc9/XjfUBUQxJjbUj9nP4xUIRw3p4R/TV
         1fEMMCcPrcQ5rbHkEvaX/Wqyn+mZQoKZWd/XmqQo2YSbZ1l9oZEH6Qa3/bT6m9bqLT3y
         DNEQ==
X-Gm-Message-State: AOAM531TomLDgGvSyVHlGlQvzVitXvS7iez8NNe8SMYgqkc/BRDmXB6X
        5iANGvlZQF5bhLCbyQ35UDqDlnMAd8OJLPmM
X-Google-Smtp-Source: ABdhPJwYkbx3moK6IBiDeaJUyG0vF+58FHQQ471qa5iiLWYh7LAIgbVq2JIXvpAZ7iENT8ayACk7jg==
X-Received: by 2002:a17:90b:300f:: with SMTP id hg15mr4260680pjb.92.1618413623873;
        Wed, 14 Apr 2021 08:20:23 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id ir3sm5205971pjb.42.2021.04.14.08.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:20:23 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 8/12] UIO/Hyper-V: Not load UIO HV driver in the
 isolation VM.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
References: <20210413152217.3386288-1-ltykernel@gmail.com>
 <20210413152217.3386288-9-ltykernel@gmail.com> <YHXAL+83iHPK8O/Q@kroah.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <e54446fb-f9d9-2768-f73f-01a94cf635ea@gmail.com>
Date:   Wed, 14 Apr 2021 23:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHXAL+83iHPK8O/Q@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Greg:
	Thanks for your review.

On 4/14/2021 12:00 AM, Greg KH wrote:
> On Tue, Apr 13, 2021 at 11:22:13AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> UIO HV driver should not load in the isolation VM for security reason.
> 
> Why?  I need a lot more excuse than that.

The reason is that ring buffers have been marked as visible to host.
UIO driver will expose these buffers to user space and user space
driver hasn't done some secure check for data from host. This
is considered as insecure in isolation VM.

> 
> Why would the vm allow UIO devices to bind to it if it was not possible?
> Shouldn't the VM be handling this type of logic and not forcing all
> individual hyperv drivers to do this?
> 
> This feels wrong...

Hypervisor exposes network and storage devices but can't prohibit guest
from binding these devices to UIO driver.

You are right. This should not happen in the individual driver and will
try handling this in the vmbus driver level.



> 
> thanks,
> 
> greg k-h
> 
