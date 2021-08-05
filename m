Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28303E0EC0
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhHEHAg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 03:00:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48562 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHEHAg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 03:00:36 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 4BF88209E044; Thu,  5 Aug 2021 00:00:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BF88209E044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1628146822;
        bh=DkvT+P/azRRMQG1BsDMNIW1kNHl9G9/qgI0tmgKhpLI=;
        h=From:To:Cc:Subject:Date:From;
        b=ahPBJA3IIY+Xyh+kRZ1FZhUSaRJKuP2VFCTlaeN1Y9qsCU+INlSsIM9Lq5oMzvuhC
         TGTmk+uaJ7nd3eh5DP6vVt+eR2AAClww25DMdflZFVwbAn9NWcoaoY9hlOBRm8F2lf
         kYyC+3JGbiGwMRsIl/8VsExQhVXq4DS4uU3RCf5A=
From:   longli@linuxonhyperv.com
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
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
Subject: [Patch v5 0/3] Introduce a driver to support host accelerated access to Microsoft Azure Blob for Azure VM
Date:   Thu,  5 Aug 2021 00:00:09 -0700
Message-Id: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Azure Blob storage [1] is Microsoft's object storage solution for the
cloud. Users or client applications can access objects in Blob storage via
HTTP, from anywhere in the world. Objects in Blob storage are accessible
via the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure
Storage client library. The Blob storage interface is not designed to be a
POSIX compliant interface.

Problem: When a client accesses Blob storage via HTTP, it must go through
the Blob storage boundary of Azure and get to the storage server through
multiple servers. This is also true for an Azure VM.

Solution: For an Azure VM, the Blob storage access can be accelerated by
having Azure host execute the Blob storage requests to the backend storage
server directly.

This driver implements a VSC (Virtual Service Client) for accelerating Blob
storage access for an Azure VM by communicating with a VSP (Virtual Service
Provider) on the Azure host. Instead of using HTTP to access the Blob
storage, an Azure VM passes the Blob storage request to the VSP on the
Azure host. The Azure host uses its native network to perform Blob storage
requests to the backend server directly.

This driver doesn’t implement Blob storage APIs. It acts as a fast channel
to pass user-mode Blob storage requests to the Azure host. The user-mode
program using this driver implements Blob storage APIs and packages the
Blob storage request as structured data to VSC. The request data is modeled
as three user provided buffers (request, response and data buffers), that
are patterned on the HTTP model used by existing Azure Blob clients. The
VSC passes those buffers to VSP for Blob storage requests.

The driver optimizes Blob storage access for an Azure VM in two ways:

1. The Blob storage requests are performed by the Azure host to the Azure
Blob backend storage server directly.

2. It allows the Azure host to use transport technologies (e.g. RDMA)
available to the Azure host but not available to the VM, to reach to Azure
Blob backend servers.
 
Test results using this driver for an Azure VM:
100 Blob clients running on an Azure VM, each reading 100GB Block Blobs.
(10 TB total read data)
With REST API over HTTP: 94.4 mins
Using this driver: 72.5 mins
Performance (measured in throughput) gain: 30%.
 
[1] https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andra Paraschiv <andraprs@amazon.com>
Cc: Siddharth Gupta <sidgup@codeaurora.org>
Cc: Hannes Reinecke <hare@suse.de>

Changes:

v2:
Refactored the code in vmbus to scan devices
Reworked Azure Blob driver and moved user-mode interfaces to uapi

v3:
Changed licensing language
Patch format passed "checkpatch --strict"
debugfs and logging, module parameter cleanup
General code clean up
Fix device removal race conditions

v4:
Addressed licencing issues
Changed to dynamic device model

v5:
Added problem statement and test numbers to patch 0
Changed uapi header file to explicitly include all header files needed for user-mode
Make the driver handle vmbus rescind without waiting on user-mode for device removal

Long Li (3):
  Drivers: hv: vmbus: add support to ignore certain PCIE devices
  Drivers: hv: add Azure Blob driver
  Drivers: hv: Add to maintainer for Hyper-V/Azure drivers

 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 MAINTAINERS                                        |   2 +
 drivers/hv/Kconfig                                 |  11 +
 drivers/hv/Makefile                                |   1 +
 drivers/hv/channel_mgmt.c                          |  55 +-
 drivers/hv/hv_azure_blob.c                         | 574 +++++++++++++++++++++
 include/linux/hyperv.h                             |   9 +
 include/uapi/misc/hv_azure_blob.h                  |  35 ++
 8 files changed, 683 insertions(+), 6 deletions(-)
 create mode 100644 drivers/hv/hv_azure_blob.c
 create mode 100644 include/uapi/misc/hv_azure_blob.h

-- 
1.8.3.1

