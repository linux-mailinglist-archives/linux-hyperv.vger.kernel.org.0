Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4122C4AFBE
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jun 2019 03:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFSB4u (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jun 2019 21:56:50 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:46654 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSB4u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 21:56:50 -0400
Received: by mail-io1-f45.google.com with SMTP id i10so34349961iol.13;
        Tue, 18 Jun 2019 18:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ix5Dfi/dkMWuL6+NBxIipP5XBxtV2JHvQAM496TixnA=;
        b=NM7iFiBm9AcwTZxgpCTJ7ENufhBoK11MdreuVOpDr7vpYCvD0JqtkxVhZOgz9NMc5g
         KBw23PzXOi7mBrqmkM6x+B9rpubLHjFsFysldj3GsgQOTnQRl1v5RO6NtDaloNA5vdMn
         NXo56YzvzutWit29DNI6yW9d0cjSR91eJW360xShk7g6SbYEJaiJAEeY58gt9ktTH5//
         LqXLqy1MbuGWV6X3cLbu1T8ecAJNX4iiEvuHb9Ft9NlSqPKRF38thaKUe8Zof1++09Bq
         6/6S2p3o+kkspD1z0DmuF2rkkh8t1mnL4omb/h9aVHsDN0jUQ3nqf/v1D5y8vGWkJDpQ
         y98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ix5Dfi/dkMWuL6+NBxIipP5XBxtV2JHvQAM496TixnA=;
        b=ShqPPE4J+1bokV+pkq/6xZ7WvvEtu56Y85ruRglDSgnTaFh5QkFjd1YNVJFZdfixEH
         uf16OJTJmgXnQFAXfyKhhA78+/uCfenh+pUyF85XPUGA2WgbHmxO5inwKd0FljdQZ3Wp
         hq6tK45Y9AziaK0uV9+E/6hSA/9g5eNb8xZjEwjpkCgj0z2DTeLksi7U7KBQBkTMgpkR
         891dYWTZAL3x8EZAN718o5pyHcZL5dBY854eRiYARzdv65N+A9sO5RgJt6c5/T2lzxy6
         lCVv+cD0wfPcv7wx7LPGk0efkqmeYpSFhllMypSUHXeiRdsZldcSdWn/bINPinczzSUk
         9LMA==
X-Gm-Message-State: APjAAAXYlKo489s1KNu0hs1a7NpT41zfRnyXvMWU3YA5fPgyOFzHLE0f
        BdUhDHfrjUlZq9CSkcf/BA==
X-Google-Smtp-Source: APXvYqxYo1AvZW5YC39VWmRxsXda+tg6UF5zULyzvOQPoEKPBoQiFHtI9M9DOtcpQXMU++wkpulVEw==
X-Received: by 2002:a05:6638:3d6:: with SMTP id r22mr5999891jaq.71.1560909409374;
        Tue, 18 Jun 2019 18:56:49 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id n17sm13670828iog.63.2019.06.18.18.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 18:56:48 -0700 (PDT)
Date:   Tue, 18 Jun 2019 21:56:46 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: Add ability to change scsi queue depth
Message-ID: <20190619015646.GA21617@Test-Virtual-Machine>
References: <20190614234822.5193-1-brandonbonaby94@gmail.com>
 <yq1fto6xtxw.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1fto6xtxw.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 18, 2019 at 09:08:59PM -0400, Martin K. Petersen wrote:
> 
> Branden,
> 
> > Adding functionality to allow the SCSI queue depth to be changed, by
> > utilizing the "scsi_change_queue_depth" function.
> 
> Applied to 5.3/scsi-queue. Please run checkpatch before submission. I
> fixed it up this time.
> 
> Thanks!

Oh I see what you mean about the brackets, thanks will do next time.
