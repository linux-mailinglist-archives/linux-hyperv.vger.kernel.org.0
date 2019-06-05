Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9947366AC
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFEVU1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 17:20:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44752 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEVU0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 17:20:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so22646pgp.11
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Jun 2019 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbSNX6Rtq6xgkNTyw8B4sm3beoNnOfKEeukM3sDO+IE=;
        b=bA0CKpMOuTL8Y8LhFO/IeHVomPpIS8AtGZw3EP/UDhOLHCT/8aDT3fs30kyHtqBpHx
         6q8RHl1CbJnYXGjyC/3UhR0rChzmdqcegMm7RkY2yrnY4O1DEVqzkwfCZ5bdd0yVNdnA
         sAfhSsM+gSI6ILdxaSkY3DlIn/CSvNZB/q/Ew08XgSxJCoGytGqJexKnbRo79LvQ022N
         OtG+79ytL842FSuiDZswVfMViNrT5Uf2p4d3mFUCkTdRXGInen4v12eUUtrsao4UZ3f5
         6QkPwLkzG7yJyYVDQjqNJ0fWc2TONnB00scR1otaIMCfmdcgsGWg4tAYgYStHdzYZ2x+
         Rl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbSNX6Rtq6xgkNTyw8B4sm3beoNnOfKEeukM3sDO+IE=;
        b=n9ZWIQIRyM0IP4Og5Nrw221p+CvuL51OASj9XtkfnbAaYacyIPTdNgkzjRBp1pOaTx
         KLdXaoGUlp4alV66Gy5QeSXA8wJ+/tLh2gdiAeKqi0rj2//11dRtl2UD0bg0XzpP6YfJ
         vL80JJA2IMFrlH/aKPZtd7YwlWlJJauS5mK59UhI9GLaM4Dz5nDu6mmM3j3saB6wC4kE
         h3C2nRo6/S2FV8Uo25uuoL0Qp+AZCxGbBAkjmHoTixG0mlnZAiPlYDKJAtolw9fPCUaY
         Dnfzhopk8pXVCti0L6v2g4JldGK4MY+oP87d63K4SABjSkKTPOZctE4+2htbJXM9pNq3
         0egw==
X-Gm-Message-State: APjAAAVV3yfdzwKJHEeUv3/iZsXZ1ZzPOq0kn9+qOVDZ60Nj76uws3JA
        5WzxtPz2w1HeG4dTlgtsFf7RPy1Yeto=
X-Google-Smtp-Source: APXvYqyZitJoRGelzSbSpcT25jvfTuWBHAaXphn8TImPNCrJZYSK6JjkbR81/MF9LsMtiDsNLhMUTA==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr47893479pjj.44.1559769626247;
        Wed, 05 Jun 2019 14:20:26 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d24sm4340pjv.24.2019.06.05.14.20.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 14:20:26 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:20:24 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605142024.1589a7b4@hermes.lan>
In-Reply-To: <20190605192647.GA25034@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
        <20190605185637.GA31439@infradead.org>
        <20190605120640.00358689@hermes.lan>
        <20190605190722.GA19684@infradead.org>
        <20190605121020.1a41b753@hermes.lan>
        <20190605192647.GA25034@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 5 Jun 2019 12:26:47 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 05, 2019 at 12:10:20PM -0700, Stephen Hemminger wrote:
> > > Sure.  But they should not get a way out for just one specific driver.  
> > 
> > There are people running new kernels on 6 year old distributions.
> > Was every distribution smart enough then? If you think so, then
> > this not necessary.  
> 
> I think you are missing my point.  If we want a way to disable this,
> we:
> 
>  a) want it opt-in
>  b) it needs to for the whole SCSI layer and not just one driver

Based on feedback from the Program Manager who handles the distros
the patch for storvsc is not needed.

SCSI device naming was never deterministic anyway.  
Cloud-init relies on the same mechanism as the Azure agent to detect the OS and ephemeral disk. 
