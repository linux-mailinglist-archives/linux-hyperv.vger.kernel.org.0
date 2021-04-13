Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6135E359
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhDMQBL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 12:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhDMQBJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 12:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62C24610C8;
        Tue, 13 Apr 2021 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618329650;
        bh=36caYnOYrBysPRis8Xi0aV461lg5QXZiylbioznubqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMcxw1aS6YOrb95DFkjBV7CD/K74VpSoFxzGK/yxfTiTne6CqZvw5aaKdztD0u+u8
         Ar/w8e5ACyMcRc3WMIbhy96pHbXVQ5CKEQz6aJrP5kql2le9fws1SqUcCB2W3xRCr3
         iHUWV6X4W41J+UryGKDQ7k93Jxdi8ajL0ij297LM=
Date:   Tue, 13 Apr 2021 18:00:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: Re: [RFC V2 PATCH 8/12] UIO/Hyper-V: Not load UIO HV driver in the
 isolation VM.
Message-ID: <YHXAL+83iHPK8O/Q@kroah.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
 <20210413152217.3386288-9-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413152217.3386288-9-ltykernel@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 13, 2021 at 11:22:13AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> UIO HV driver should not load in the isolation VM for security reason.

Why?  I need a lot more excuse than that.

Why would the vm allow UIO devices to bind to it if it was not possible?
Shouldn't the VM be handling this type of logic and not forcing all
individual hyperv drivers to do this?

This feels wrong...

thanks,

greg k-h
