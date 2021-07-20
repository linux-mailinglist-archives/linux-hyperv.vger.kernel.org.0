Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6C3CF2AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 05:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhGTCxG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jul 2021 22:53:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40618 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbhGTCut (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jul 2021 22:50:49 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id D1E5020B7178; Mon, 19 Jul 2021 20:31:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1E5020B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1626751883;
        bh=+yPMJaQtcLTsFBtRILqc6LXrWgm8NmSEzBdhbuZktUA=;
        h=From:To:Cc:Subject:Date:From;
        b=LFmorg5sZOIHyaC+PyRq9EbTsBjTNI7X10BXa7e9FoOQ3px+NYgeLeNUMhbWznrES
         xlfh83t1UJU7oecoorR87Mg5lLBsmXPoOFtBIoCalbAatJYGTR8ICpfMgKohjfb5Dh
         uiS17hOFRh0nmsBNcNIEvsjTGpQaHZqGGpF4k6ow=
From:   longli@linuxonhyperv.com
To:     linux-fs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v4 0/3] Introduce a driver to support host accelerated access to Microsoft Azure Blob
Date:   Mon, 19 Jul 2021 20:31:03 -0700
Message-Id: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Microsoft Azure Blob storage service exposes a REST API to applications
for data access.
(https://docs.microsoft.com/en-us/rest/api/storageservices/blob-service-rest-api)

This patchset implements a VSC (Virtualization Service Consumer) that
communicates with a VSP (Virtualization Service Provider) on the Hyper-V
host to execute Blob storage access via native network stack on the host.
This VSC doesn't implement the semantics of REST API. Those are implemented
in user-space. The VSC provides a fast data path to VSP.

Answers to some previous questions discussing the driver:

Q: Why this driver doesn't use the block layer

A: The Azure Blob is based on a model of object oriented storage. The
storage object is not modeled in block sectors. While it's possible to
present the storage object as a block device (assuming it makes sense to
fake all the block device attributes), we lose the ability to express
functionality that are defined in the REST API. 

Q: You just lost all use of caching and io_uring and loads of other kernel
infrastructure that has been developed and relied on for decades?

A: The REST API is not designed to have caching at system level. This
driver doesn't attempt to improve on this. There are discussions on
supporting ioctl() on io_uring (https://lwn.net/Articles/844875/), that
will benefit this driver. The block I/O scheduling is not helpful in this
case, as the Blob application and Blob storage server have complete
knowledge on the I/O pattern based on storage object type. This knowledge
doesn't get easily consumed by the block layer.

Q: You also just abandoned the POSIX model and forced people to use a
random-custom-library just to access their storage devices, breaking all
existing programs in the world?

A: The existing Blob applications access storage via HTTP (REST API). They
don't use POSIX interface. The interface for Azure Blob is not designed
on POSIX.

Q: What programs today use this new API?

A: Currently none is released. But per above, there are also none using
POSIX.

Q: Where is the API published and what ensures that it will remain stable?

A: Cloud based REST protocols have similar considerations to the kernel in
terms of interface stability. Applications depend on cloud services via
REST in much the same way as they depend on kernel services. Because
applications can consume cloud APIs over the Internet, there is no
opportunity to recompile applications to ensure compatibility. This causes
the underlying APIs to be exceptionally stable, and Azure Blob has not
removed support for an exposed API to date. This driver is supporting a
pass-through model where requests in a guest process can be reflected to a
VM host environment. Like the current REST interface, the goal is to ensure
that each host provide a high degree of compatibility with each guest, but
that task is largely outside the scope of this driver, which exists to
communicate requests in the same way an HTTP stack would. Just like an HTTP
stack does not require updates to add a new custom header or receive one
from a server, this driver does not require updates for new functionality
so long as the high level request/response model is retained.

Q: What happens when it changes over time, do we have to rebuild all
userspace applications?

A: No. We don’t rebuild them all to talk HTTP either. In the current HTTP
scheme, applications specify the version of the protocol they talk, and the
storage backend responds with that version.

Q: What happens to the kernel code over time, how do you handle changes to
the API there?

A: The goal of this driver is to get requests to the Hyper-V host, so the
kernel isn’t involved in API changes, in the same way that HTTP
implementations are robust to extra functionality being added to HTTP.

Long Li (3):
  Drivers: hv: vmbus: add support to ignore certain PCIE devices
  Drivers: hv: add Azure Blob driver
  Drivers: hv: Add to maintainer for Azure Blob driver

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
addressed licencing issues
changed to dynamic device model

Long Li (3):
  Drivers: hv: vmbus: add support to ignore certain PCIE devices
  Drivers: hv: add Azure Blob driver
  Drivers: hv: Add to maintainer for Hyper-V/Azure drivers

 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 MAINTAINERS                                   |   2 +
 drivers/hv/Kconfig                            |  11 +
 drivers/hv/Makefile                           |   1 +
 drivers/hv/channel_mgmt.c                     |  55 +-
 drivers/hv/hv_azure_blob.c                    | 628 ++++++++++++++++++
 include/linux/hyperv.h                        |   9 +
 include/uapi/misc/hv_azure_blob.h             |  34 +
 8 files changed, 736 insertions(+), 6 deletions(-)
 create mode 100644 drivers/hv/hv_azure_blob.c
 create mode 100644 include/uapi/misc/hv_azure_blob.h

-- 
2.25.1

