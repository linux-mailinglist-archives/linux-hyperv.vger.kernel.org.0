Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193DA3E1A18
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhHERJ3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 13:09:29 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:40837 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbhHERJ1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 13:09:27 -0400
Received: by mail-pj1-f52.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so13183300pji.5;
        Thu, 05 Aug 2021 10:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JtnpusPlT79XTrJHbklEK8t3wy7ojLamNshY8HM0u5k=;
        b=a69fthTkvrWoRk3vkYNJ7NNsH6FA5elUFEDM5ZliIZ1JdgFcm7sgvK0h+uqtTPpDk9
         KWz/d3Xjk4mwbkMSuKJlnEnBW0fkKH6P3yW8mgPKbel/NOkLONYdziSxU+VCL/l5aIlh
         O+W0ZaMnBPFx1FOfdm9wFMVVawTgp0li4WYi/5ox5DjX4Hhm3emWNx5mOAaV7sM9tnsb
         YSRF37NNZpoa498yZli6JqtzFTn7+YRjDWQFIZAIr/lJ0sa36HPZsQaANuu4xz0zuMUb
         1PrDxTIY1xIAXW7LZMBQo5moTiPdNgiEg2c+L/JVdFeD2Z0d68fJ4ArExVZ6q5mj7K4+
         RWfQ==
X-Gm-Message-State: AOAM531aPBSWYdwR4ujgN2eSMh05tPLY5mjk41pwKMAmxznflkKZljXc
        ripGEDXrfQhmHnuXLZAqICg=
X-Google-Smtp-Source: ABdhPJzbaI5Rtp+jVvXMdbElm6+urLa/c1ruUIMSx8Pcnk/KqAGnFzOL4cLadOeglwst2HCqDhifEw==
X-Received: by 2002:a17:902:a406:b029:12b:c50a:4289 with SMTP id p6-20020a170902a406b029012bc50a4289mr4829077plq.56.1628183351668;
        Thu, 05 Aug 2021 10:09:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id g13sm1098577pfj.128.2021.08.05.10.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:09:10 -0700 (PDT)
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
To:     longli@linuxonhyperv.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
Date:   Thu, 5 Aug 2021 10:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/5/21 12:00 AM, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Azure Blob storage [1] is Microsoft's object storage solution for the
> cloud. Users or client applications can access objects in Blob storage via
> HTTP, from anywhere in the world. Objects in Blob storage are accessible
> via the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure
> Storage client library. The Blob storage interface is not designed to be a
> POSIX compliant interface.
> 
> Problem: When a client accesses Blob storage via HTTP, it must go through
> the Blob storage boundary of Azure and get to the storage server through
> multiple servers. This is also true for an Azure VM.
> 
> Solution: For an Azure VM, the Blob storage access can be accelerated by
> having Azure host execute the Blob storage requests to the backend storage
> server directly.
> 
> This driver implements a VSC (Virtual Service Client) for accelerating Blob
> storage access for an Azure VM by communicating with a VSP (Virtual Service
> Provider) on the Azure host. Instead of using HTTP to access the Blob
> storage, an Azure VM passes the Blob storage request to the VSP on the
> Azure host. The Azure host uses its native network to perform Blob storage
> requests to the backend server directly.
> 
> This driver doesn’t implement Blob storage APIs. It acts as a fast channel
> to pass user-mode Blob storage requests to the Azure host. The user-mode
> program using this driver implements Blob storage APIs and packages the
> Blob storage request as structured data to VSC. The request data is modeled
> as three user provided buffers (request, response and data buffers), that
> are patterned on the HTTP model used by existing Azure Blob clients. The
> VSC passes those buffers to VSP for Blob storage requests.
> 
> The driver optimizes Blob storage access for an Azure VM in two ways:
> 
> 1. The Blob storage requests are performed by the Azure host to the Azure
> Blob backend storage server directly.
> 
> 2. It allows the Azure host to use transport technologies (e.g. RDMA)
> available to the Azure host but not available to the VM, to reach to Azure
> Blob backend servers.
>   
> Test results using this driver for an Azure VM:
> 100 Blob clients running on an Azure VM, each reading 100GB Block Blobs.
> (10 TB total read data)
> With REST API over HTTP: 94.4 mins
> Using this driver: 72.5 mins
> Performance (measured in throughput) gain: 30%.
>   
> [1] https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction

Is the ioctl interface the only user space interface provided by this 
kernel driver? If so, why has this code been implemented as a kernel 
driver instead of e.g. a user space library that uses vfio to interact 
with a PCIe device? As an example, Qemu supports many different virtio 
device types.

Thanks,

Bart.

