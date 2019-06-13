Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06B744CEE
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2019 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfFMUEQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jun 2019 16:04:16 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:44351 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfFMUEQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jun 2019 16:04:16 -0400
Received: by mail-io1-f47.google.com with SMTP id s7so594805iob.11
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Jun 2019 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=DI3nny5EkaaAj92ROhz8+oF1JyVO+F50iFiYFfny5cg=;
        b=Vf0Co9J1FWQf/mNg9X22WqwFrqk1bWNDchM2WOC0coX4mVxqvFdL4M7qSSiticNd+/
         +3h8YyGJXb6Dp9fwIq4WsLEKSNJVZR/j3S/HsXXpkjb7r3yKx1VfkTt2fSEW7Upj2InB
         vpUy4mSkuPaOLlVxWUk8m4jGlNkrR8m+OQY9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=DI3nny5EkaaAj92ROhz8+oF1JyVO+F50iFiYFfny5cg=;
        b=YxezWYXjOfNDocSXfPT/su1jCb/zuiliAvHisetBwYYMF6g/BoLtDWpiYdklwXTppD
         467dlDVmpQ5kK+ed1LmGcmsjaQGM5I3i5/Or8bSaMBueqnCwLq1C3cAtHkdgux/n7pZp
         ykmQ49IRUc3dvGnPlVckT3BY2obvc5pTlJrm4juMVtKNjUT9ZtfT3BPrOZIWrZ03+f3X
         U58EM1Qt5hy3WkpRldgS7K4XySJSN1h5S3ye0yBgK0m5kmb0zaWw9G100ynYf146UBzd
         AFYz6k86R08MWUBXfk8uL4oNhhQ0R1imzhEc5Pt9wS0HIgm2W3qypibUT7hO6NmARETs
         kO1A==
X-Gm-Message-State: APjAAAUWyV7xZid99UT+xGaNA1cvc5Ou5TeLUVgfx0Ofa4DVPMaxkHQk
        RrCo2GFqTxbNocGbAB2dHJTosRD8D/sCTgtATV+b3Q==
X-Google-Smtp-Source: APXvYqzt6T4yoFnlQQM4Io9z3VVKv9jXWB1wt4QkxYaqK+pkTNNNf6XRH7RjKzaoumZniM5JtnYN2SZhYMEkCQ+APaM=
X-Received: by 2002:a5d:9b1a:: with SMTP id y26mr37376851ion.238.1560456255599;
 Thu, 13 Jun 2019 13:04:15 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com> <20190613084458.GB13221@lst.de>
In-Reply-To: <20190613084458.GB13221@lst.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQNLjZIO2zMn7N+9xPobnDbFSu4o5gI2RJdJAgF+bYgCEzcr9aN60eSw
Date:   Fri, 14 Jun 2019 01:34:00 +0530
Message-ID: <d411baa1bdd34f1a1289480d13fe1cef@mail.gmail.com>
Subject: RE: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        PDL-MPT-FUSIONLINUX <mpt-fusionlinux.pdl@broadcom.com>,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>
> So before I respin this series, can you help with a way to figure out
for
> mpt3sas and megaraid if a given controller supports NVMe devices at all,
so
> that we don't have to set the virt boundary if not?


In MegaRaid we have below enum -        VENTURA_SERIES and AERO_SERIES
supports NVME

enum MR_ADAPTER_TYPE {
        MFI_SERIES = 1,
        THUNDERBOLT_SERIES = 2,
        INVADER_SERIES = 3,
        VENTURA_SERIES = 4,
        AERO_SERIES = 5,
};

In mpt3sas driver we have below method - If IOC FACT reports NVME Device
support in Protocol Flags, we can consider it as HBA with NVME drive
support.

ioc->facts.ProtocolFlags & MPI2_IOCFACTS_PROTOCOL_NVME_DEVICES

Kashyap
